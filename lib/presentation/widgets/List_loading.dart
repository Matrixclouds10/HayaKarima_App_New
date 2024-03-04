import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constants/my_colors.dart';
import '../../constants/strings.dart';
import 'Skeleton.dart';

class List_loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        margin: EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
        child: Row(
          children: [
            const Skeleton(height: 200, width: 200),
            const SizedBox(width: defaultPadding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Skeleton(width: 80),
                  const SizedBox(height: defaultPadding / 2),
                  const Skeleton(),
                  const SizedBox(height: defaultPadding / 2),
                  const Skeleton(),
                  const SizedBox(height: defaultPadding / 2),
                  // Row(
                  //   children: const [
                  //     Expanded(
                  //       child: Skeleton(),
                  //     ),
                  //     SizedBox(width: defaultPadding),
                  //     Expanded(
                  //       child: Skeleton(),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            )
          ],
        ));
  }
}
