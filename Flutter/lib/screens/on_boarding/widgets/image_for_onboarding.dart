import 'package:digi3map/common/constants.dart';
import 'package:digi3map/data/models/on_boarding_data.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImagesForOnBoarding extends StatefulWidget {
  final PageController pageController;
  final Function(int) changedFunction;
  final int page;
  ImagesForOnBoarding({
    required this.pageController,
    required this.changedFunction,
    required this.page,
    Key? key
  }):super(key: key);
  final List<Widget> imagesWidget=[
    Image.asset(AssetsLocation.onBoarding1),
    Image.asset(AssetsLocation.onBoarding2),
    Image.asset(AssetsLocation.onBoarding3),
  ];


  @override
  _ImagesForOnBoardingState createState() => _ImagesForOnBoardingState();
}

class _ImagesForOnBoardingState extends State<ImagesForOnBoarding> {
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height*0.4,
          width: size.width,
          child: PageView(
            physics: const BouncingScrollPhysics(),
            controller: widget.pageController,
            onPageChanged: widget.changedFunction,
            children:widget.imagesWidget,
          ),
        ),
        Constants.kSmallBox,
        Center(
          child: SmoothPageIndicator(
            controller: widget.pageController,
            count: 3,
            effect: ExpandingDotsEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: ColorConstant.kBlueColor,
              dotColor: ColorConstant.kBlueColor.withOpacity(0.2),
            ),
          ),
        ),
        Constants.kSmallBox,
        Text(
            OnBoardingData.dataList[widget.page].heading,
            textAlign: TextAlign.center,
            style: Styles.onBoardingHeading
        ),
        Constants.kSmallBox,
        Text(
          OnBoardingData.dataList[widget.page].value,
          textAlign: TextAlign.center,
          style: Styles.onBoardingValue,
        ),

      ],
    );

  }
}