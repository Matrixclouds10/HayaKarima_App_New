import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hayaah_karimuh/empolyer/utils/my_colors.dart';
import 'package:hexcolor/hexcolor.dart';

class Widget_Intro extends StatelessWidget {
  var image;

  Widget_Intro(this.image);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Container(
      width: width,
      height: height * .43,
      decoration: BoxDecoration(
        color: HexColor(MyColors.green),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: height * .42,
            width: width,
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              placeholder: (context, url) => Image.asset('$image'),
              errorWidget: (context, url, error) => Image.asset(
                '$image',
                fit: BoxFit.fill,
              ),
              imageUrl: '',
            ),
          )
          // Container(
          //   width: width,
          //   height: height*.41,
          //   margin: EdgeInsets.only(bottom: 1),
          //   child: Positioned.fill(  //
          //     child: Image(
          //       image: AssetImage(image),
          //       fit : BoxFit.fill,
          //     ),
          //   ),
          //
          // ),
        ],
      ),
    );
  }
}
