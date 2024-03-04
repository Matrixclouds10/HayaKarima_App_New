import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constants/my_colors.dart';
import '../../constants/strings.dart';
import 'Skeleton.dart';

class List_DonationState_Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        margin: EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: defaultPadding / 2),
                  const Skeleton(
                    height: 80,
                  ),
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
