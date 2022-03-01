import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/common/widgets/logo_widget.dart';
import 'package:digi3map/screens/fitness_page/view/fitness_page.dart';
import 'package:digi3map/screens/fitness_page/widgets/fitness_listview.dart';
import 'package:digi3map/screens/homepage/provides/isLoggedValue.dart';
import 'package:digi3map/screens/homepage/views/random_todo_add.dart';
import 'package:digi3map/screens/homepage/views/splash_page.dart';
import 'package:digi3map/screens/homepage/widgets/energy_filter_widget.dart';
import 'package:digi3map/screens/homepage/widgets/homepage_drawer.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';


class HomeTask extends StatelessWidget {
  HomeTask({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        endDrawer: Drawer(child: HomePageDrawer()),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          title:  SizedBox(
              height: 30,
              width: 100,
              child: FittedBox(
                  child: LogoWidget()
              )
          ),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: Constants.kPaddingValue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "Current Best Task",
                      style: Styles.mediumHeading,
                    ),
                  ),
                  TextButton(
                      onPressed: (){
                        showModalBottomSheet(
                            context: context,
                            builder: (_){
                              return EnergyFilterWidget();
                            }
                        );
                      },
                      child: Text(
                        "Energy Filter"
                      )
                  )
                ],
              ),
              Expanded(
                child: SizedBox(
                  width: size.width,
                  child: Column(

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                                "Workout",
                              style: Styles.mediumHeading,
                            ),
                          ),
                          TextButton(
                              onPressed: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>  const FitnessPage()));

                              },
                              child: Text(
                                  "Open Page"
                              )
                          )
                        ],
                      ),
                      Constants.kVerySmallBox,
                      Expanded(
                          child: FitnessListView()
                      ),
                      Constants.kVerySmallBox,
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                onPressed: (){},
                                child: Text(
                                  "Previous",
                                  style: Styles.smallHeading,
                                ),
                              )
                          ),
                          SizedBox(width: 10,),
                          ClipOval(
                            child: InkWell(
                              splashColor: Colors.red,
                              onTap: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => const RandomTodoAdd()));
                              },
                              child: Container(
                                color: ColorConstant.kBlueColor,
                                child: Icon(
                                  Icons.add,
                                  size: 60,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                              child: ElevatedButton(
                                onPressed: (){},
                                child: Text(
                                  "Next",
                                  style: Styles.smallHeading,
                                ),
                              )
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
