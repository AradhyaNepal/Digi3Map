import 'dart:convert';
import 'package:digi3map/common/classes/HttpException.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/habits/provider/habits_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HabitTaskProvider with ChangeNotifier{
  List<Habit> currentHabitsList=[];
  bool isLoading=true;
  HabitTaskProvider(){
    getHabitsList();
  }

  Future<void> getHabitsList() async{
    final sharedPref=await SharedPreferences.getInstance();
    String token= sharedPref.getString(Service.tokenPrefKey)??"";
    int userId=sharedPref.getInt(Service.userId)??0;
    Uri userHabits=Uri.parse(Service.baseApi+Service.userHabits+"$userId/");

    http.Response response=await http.get(
      userHabits,
      headers: {
        "Authorization":"Token $token"
      }

    );
    final userHabitsData=json.decode(response.body);
    Uri excludedHabits=Uri.parse(Service.baseApi+Service.excludedHabit);
    if(response.statusCode>299) throw HttpException(message: userHabitsData.toString());
    response=await http.get(
        excludedHabits,
        headers: {
          "Authorization":"Token $token"
        }

    );
    final excludedHabitsData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(message: excludedHabitsData.toString());
    int domainPoints=0;
    currentHabitsList.clear();
    int highCount=0;
    int lowCount=0;
    int mediumCount=0;
    int highExtraPoints=0;
    int lowExtraPoints=0;
    int mediumExtraPoints=0;
    for (Map<String,dynamic> map in userHabitsData){
      Habit habit=Habit.fromMap(map: map);
      currentHabitsList.add(habit);
      domainPoints+=habit.points??0;
      if(habit.domainPriority=="High"){
        highCount++;
      }else if(habit.domainPriority=="Medium"){
        mediumCount++;
      }
      else{
        lowCount++;
      }
    }
    for (Map<String,dynamic> map in excludedHabitsData){
      currentHabitsList.removeWhere((element) => element.id==map['habitId']);
    }

    if(currentHabitsList.length>1){
      //If length is less than one then it does not make any sense to do sorting
      double domainPlusPriorityPoints=(5/3)*domainPoints;// 60% From Domain Balanced, 40 % from domain priority
      double priorityPoints=domainPlusPriorityPoints-domainPoints;
      int totalPriorityBasedFactor=5*highCount+3*mediumCount+2*lowCount+1;//Plus one to avoid infinite error
      highExtraPoints=((highCount/totalPriorityBasedFactor)*priorityPoints).toInt();
      lowExtraPoints=((lowCount/totalPriorityBasedFactor)*priorityPoints).toInt();
      mediumExtraPoints=((mediumCount/totalPriorityBasedFactor)*priorityPoints).toInt();
      for (int index=0;index<currentHabitsList.length;index++) {
        Habit current=currentHabitsList[index];
        if(current.domainPriority=="High"){
          current.points=current.points??0-highExtraPoints;
        }
        else if(current.domainPriority=="Medium"){
          current.points=current.points??0-mediumExtraPoints;

        }
        else{
          current.points=current.points??0-lowExtraPoints;

        }
        currentHabitsList[index]=current;
      }




      currentHabitsList.sort((a,b)=>a.points??0.compareTo(b.points??0));
    }


    isLoading=false;
    notifyListeners();

  }


  Future<void> addTransaction({required int habitId,bool failed=false}) async{
    Uri uri=Uri.parse(Service.baseApi+Service.addHabitTransaction+"${failed?0:1}/");
    final sharedPref=await SharedPreferences.getInstance();
    String token =sharedPref.getString(Service.tokenPrefKey)??"";
    int userId=sharedPref.getInt(Service.userId)??0;
    DateTime today = DateTime.now();
    String dateSlug ="${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
    http.Response response=await http.post(
        uri,
      headers: {
          "Authorization":"Token $token",
        "Content-Type":"application/json"
      },
      body: json.encode({
        "completed_date":dateSlug,
        "habitId":habitId,
        "userId":userId
      })
    );
    final transactionResponse=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(message: transactionResponse.toString());
    if(!failed){
      uri=Uri.parse(Service.baseApi+Service.addDomainHabitPoints+"$habitId/");
      response=await http.get(
        uri,
        headers: {
          "Authorization":"Token $token"
        }
      );
      final pointsResponse=json.decode(response.body);
      if(response.statusCode>299) throw HttpException(message: pointsResponse.toString());

      uri=Uri.parse(Service.baseApi+Service.addChainJson);
      print("Date $dateSlug");
      response=await http.post(
        uri,
        body: json.encode({
          "collected_date":dateSlug,
          "habit_id":habitId
        }),
        headers: {
          "Content-Type":"application/json"
        }
      );
      final milestoneResponse=json.decode(response.body);
      if(response.statusCode>299) throw HttpException(message: milestoneResponse.toString());
    }
    await getHabitsList();
  }
}