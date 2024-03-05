import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hayaah_karimuh/empolyer/screens/auth_view.dart';
import 'package:hayaah_karimuh/empolyer/utils/images.dart';
import 'package:hexcolor/hexcolor.dart';

import '../utils/my_colors.dart';
import '../widgets/DescriptionTextWidget.dart';
import '../widgets/app_bar_auth.dart';
import '../widgets/custom_button.dart';

class AboutPage extends StatelessWidget {
  getTile(String title, String body) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ExpandablePanel(
          header: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: HexColor(MyColors.black)),
          ),
          collapsed: Text(
            body,
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          expanded: Text(
            body,
            softWrap: true,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: HexColor(MyColors.gray_light2),
        body: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              children: <Widget>[
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: HexColor(MyColors.white), //new Color.fromRGBO(255, 0, 0, 0.0),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      App_Bar_Auth(),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: width,
                  height: 170.0,
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Image.asset('assets/images/img.png'),
                    errorWidget: (context, url, error) => Image.asset(
                      PngImages.about,
                      fit: BoxFit.fill,
                    ),
                    imageUrl: '',
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                      color: HexColor(MyColors.white),
                      //new Color.fromRGBO(255, 0, 0, 0.0),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                      )),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                        child: Text(
                          "عن حياه كريمه",
                          style: TextStyle(fontSize: 18, color: HexColor(MyColors.black), fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: DescriptionTextWidget(
                            text:
                                'نها تلك المبادرة الوطنية التي أطلقها السيد الرئيس عبد الفتاح السيسي، رئيس جمهورية مصر العربية، 2 يناير من العام الميلادي وهي مبادرة متعددة في أركانِها ومتكاملة في ملامِحِها. تنبُع هذه المبادرة من مسؤولية حضارية وبُعد إنساني قبل أي شيء آخر، فهي أبعدُ من كونها مبادرة تهدفُ إلى تحسين ظروف المعيشة والحياة اليومية للمواطن المصري، لأنها تهدف أيضا إلى التدخل الآني والعاجل لتكريم الإنسان المصري وحفظ كرامته وحقه في العيش الكريم، ذلك المواطن الذي تحمل فاتورة الإصلاح الاقتصادي والذي كان خير مساند للدولة المصرية في معركتها نحو البناء والتنمية. لقد كان المواطن المصري هو البطل الحقيقي الذي تحمل كافة الظروف والمراحل الصعبة بكل تجرد وإخلاص وحب للوطن',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width,
                  padding: const EdgeInsets.only(top: 15, bottom: 15, right: 10, left: 10),
                  margin: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
                  color: HexColor(MyColors.white),
                  child: InkWell(
                    onTap: () {},
                    child: getTile('أهداف المبادرة',
                        "   التخفيف عن كاهل المواطنين بالتجمعات الأكثر احتياجا في الريف والمناطق العشوائية. التنمية الشاملة للتجمعات الريفية الأكثر احتياجا بهدف القضاء على الفقر متعدد الأبعاد "),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 15, right: 10, left: 10),
                  margin: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
                  color: HexColor(MyColors.white),
                  child: InkWell(
                    onTap: () {},
                    child: getTile(
                        'مرتكزات المبادرة', "تضافر جهود الدولة مع خبرة مؤسسات المجتمع المدنى ودعم المجتمعات المحلية في إحداث التحسن النوعي في معيشة المواطنين المستهدفين ومجتمعاتهم على حد السواء."),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 15, right: 10, left: 10),
                  margin: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
                  color: HexColor(MyColors.white),
                  child: InkWell(
                    onTap: () {},
                    child: getTile(
                        'المبادئ الأساسية', 'الشفافية في تداول المعلومات.تعزيز الحماية الاجتماعية للفئات الأكثر احتياجا.الالتزام والتعهد لكل شريك للقيام بدوره وفق منهجية العمل ومعايير الخدمات.'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 15, right: 10, left: 10),
                  margin: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
                  color: HexColor(MyColors.white),
                  child: InkWell(
                    onTap: () {},
                    child: getTile('الفئات المستهدفة', "الأسر الأكثر احتياجا في التجمعات الريفية."),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 45, bottom: 20),
                  child: CustomButton(
                    onPressed: () async {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AuthScreen()), (route) => false);
                    },
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    buttonText: ' تسجيل الدخول',
                  ),
                ),
              ],
            )));
  }
}
