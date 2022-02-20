import 'package:digi3map/common/constants.dart';
import 'package:digi3map/data/models/effects_model.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/domain_crud/widget/image_picker.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_editable_description_widget.dart';
import 'package:digi3map/screens/user_profile/view/user_self_profile.dart';
import 'package:digi3map/screens/user_profile/widgets/activated_effect.dart';
import 'package:digi3map/screens/user_profile/widgets/copying_social_widget.dart';
import 'package:digi3map/screens/user_profile/widgets/follower_widget.dart';
import 'package:digi3map/screens/user_profile/widgets/score_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class UserOtherProfile extends StatelessWidget {
  const UserOtherProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          padding: Constants.kPagePaddingNoDown,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "User Profile",
                style: Styles.bigHeading,
              ),
              Constants.kVerySmallBox,
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomImagePicker(imageLocation: ValueNotifier(AssetsLocation.userDummyProfileLocation)),
                      Constants.kSmallBox,
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                            "Aradhya Nepal",
                          style: Styles.mediumHeading,
                        ),
                      ),
                      Constants.kVerySmallBox,
                      FollowerWidget(),
                      ScoreWidget(),
                      ProfileEditableDescriptionWidget(editable: false,),
                      Text(
                        "Email",
                        style: Styles.opacityHeadingStyle,
                      ),
                      Constants.kVerySmallBox,
                      SelectableText("aradhya.1221@gmail.com"),
                      Constants.kSmallBox,
                      CopyingSocialWidget(),
                      Constants.kSmallBox,
                      Text(
                        "Current Effect",
                        style: Styles.mediumHeading,
                      ),
                      ActivatedEffect(
                        effectModel: EffectData.effectData[0],
                      ),
                      Constants.kSmallBox,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
