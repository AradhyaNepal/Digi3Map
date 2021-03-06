import 'package:digi3map/common/classes/PlayAudio.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_editable_description_widget.dart';
import 'package:digi3map/screens/group_portle/provider/group_chat_provider.dart';
import 'package:digi3map/screens/group_portle/widget/basic_effect.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class LightingEffect extends StatelessWidget {
  final String message;
  final String sender;
  final String time;
  final bool leftAlign;
  final normalRadius=const Radius.circular(10);
  final spikeRadius=const Radius.circular(2);
  final imageSize=50.0;
  final ChatModel chatModel;
  const LightingEffect({
    required this.chatModel,
    required this.message,
    required this.sender,
    required this.time,
    this.leftAlign=true,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 0),
      child: Column(
        children: [
          Padding(
            padding: leftAlign?EdgeInsets.only(left: imageSize*0.8):EdgeInsets.only(right: imageSize*0.8),
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstant.kSanityColor,
                  borderRadius: BorderRadius.only(
                    topRight: normalRadius,
                    topLeft: normalRadius,
                    bottomLeft: leftAlign?spikeRadius:normalRadius,
                    bottomRight: leftAlign?normalRadius:spikeRadius,
                  )
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Image.asset(
                          AssetsLocation.sanityImageLocation
                      )
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  sender,

                                  key:ValueKey(sender),
                                  style: Styles.smallHeading,
                                ),
                              ),
                              Expanded(
                                child: FittedBox(
                                  child: IconButton(
                                      onPressed: (){
                                        PlayAudio.playAudio(AssetsLocation.sanityAudioLocation);
                                      },
                                      icon: Icon(
                                          Icons.volume_up
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),
                          ProfileEditableDescriptionWidget(

                            key:ValueKey(message),
                            editable: false,
                            isMessage: true,
                            description: ValueNotifier(message),
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          Text(
                            time,

                            key:ValueKey(time),
                            textAlign: leftAlign?TextAlign.left:TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
          UserImageInChat(leftAlign: leftAlign, chatModal:chatModel)

        ],
      ),
    );
  }
}
