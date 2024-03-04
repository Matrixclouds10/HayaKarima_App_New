// ignore_for_file: unnecessary_string_interpolations

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/my_colors.dart';
import '../../data/model/model_news.dart';

class News_Widget extends StatelessWidget {
  late Data_News? data_news;
  final onTap;

  News_Widget(this.data_news, this.onTap);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    DateTime now = data_news == null?DateTime.now(): DateTime.parse(data_news!.createdAt);
    String date = DateFormat.yMMMMd().format(now);
    // TODO: implement build
    return InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(left: 2.w, right: 2.w, top: 5.h, bottom: 5.h),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 4.0),
                blurRadius: 10.0,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: width * .40,
                height: height * .30,
                // color: HexColor(MyColors.Orange),

                child: AspectRatio(
                  aspectRatio: .5.w,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Image.asset('assets/loading.gif'),
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/logo.png'),
                    imageUrl: data_news!.image,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: 4.w, right: 4.w, top: 2.h, bottom: 1.h),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: width * .48,
                      margin: EdgeInsets.only(
                          left: 4.w, right: 4.w, top: 1.h, bottom: 1.h),
                      child: Text(
                        '${data_news?.title}'.replaceAll('nbsp', ' '),
                        style: TextStyle(
                          fontSize: 18.0.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      width: width * .48,
                      margin: EdgeInsets.only(
                          left: 4.w, right: 4.w, top: 5.h, bottom: 1.h),
                      child: Text(
                        data_news?.description.replaceAll('&nbsp;', ' ')??'',
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Container(
                        width: width * .48,
                        margin: EdgeInsets.only(top: 17.h, bottom: 5.h),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 2.w, right: 2.w),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.access_time_rounded,
                                size: 25.0.sp,
                                color: HexColor(MyColors.green),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 4.w, right: 4.w),
                              alignment: Alignment.center,
                              child: Text(
                                date,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: HexColor(MyColors.green)),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 10.h, bottom: 15.h),
                      width: width * .48,
                      child: Text(
                        data_news?.type??'',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: HexColor(
                              MyColors.green,
                            ),
                            fontSize: 17.sp),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
