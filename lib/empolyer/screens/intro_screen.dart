import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hayaah_karimuh/empolyer/screens/About_Screen.dart';
import 'package:hayaah_karimuh/empolyer/utils/my_colors.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/custom_button.dart';
import '../widgets/widget_intro.dart';

class Intro_Screen extends StatefulWidget {
  @override
  _Intro_Screen createState() => _Intro_Screen();

  const Intro_Screen();
}

class _Intro_Screen extends State<Intro_Screen> {
  CarouselController controller = CarouselController();
  int activeIndex = 0;
  List<String> imgs = [
    'assets/images/intro_two.png',
    'assets/images/intro_one.png',
  ];

  slider() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      child: CarouselSlider.builder(
        itemBuilder: (context, index, realIdx) {
          return Widget_Intro(imgs[index]);
        },
        options: CarouselOptions(
          onPageChanged: (index, reson) {
            setState(() {
              activeIndex = index;
            });
          },
          height: height * .45,
          // aspectRatio: 16/9,
          // initialPage: 0,
          enableInfiniteScroll: false,
          // enlargeStrategy: CenterPageEnlargeStrategy.height,
          // reverse: false,
          autoPlay: false,

          // autoPlayInterval: Duration(seconds: 3),
          // autoPlayAnimationDuration: Duration(milliseconds: 800),
          // autoPlayCurve: Curves.fastOutSlowIn,
          // enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
          viewportFraction: 1.0,
        ),
        carouselController: controller,
        itemCount: imgs.length,
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: imgs.length,
        effect: JumpingDotEffect(dotHeight: 6, dotWidth: 60, activeDotColor: HexColor(MyColors.green), dotColor: HexColor(MyColors.gray)),
      );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      body: SizedBox(
        height: height,
        child: Column(
          children: <Widget>[
            slider(),
            Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: Text(
                  "حياة كريمة",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: HexColor(MyColors.Orange_primary)),
                )),
            Container(
                margin: const EdgeInsets.only(top: 0),
                alignment: Alignment.center,
                child: Text(
                  " لكل مصري .. لكل مصرية",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300, color: HexColor(MyColors.black)),
                )),
            Container(
              margin: const EdgeInsets.only(top: 25),
              alignment: Alignment.center,
              child: buildIndicator(),
            ),
            activeIndex != 1
                ? Container(
                    margin: const EdgeInsets.only(top: 45),
                    child: CustomButton(
                      onPressed: () async {
                        controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
                      },
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      buttonText: ' التالى',
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(top: 45),
                    child: CustomButton(
                      onPressed: () async {
                        print(activeIndex);
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AboutPage()), (route) => false);
                      },
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      buttonText: 'دخول',
                    ),
                  ),
            ListTile(
                onTap: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AboutPage()), (route) => false);
                },
                title: Container(
                  margin: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back_outlined,
                        color: HexColor(MyColors.gray),
                        size: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4, right: 4),
                        child: Text(
                          "تخطى",
                          style: TextStyle(fontSize: 16, color: HexColor(MyColors.gray)),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
