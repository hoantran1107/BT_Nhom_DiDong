import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'icon_and_text_widget.dart';

class AppPrice extends StatelessWidget {
  final int price,stars;
  final String location;
  const AppPrice({Key? key, required this.price, required this.stars, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconAndText(
            icon: Icons.attach_money,
            text: price.toString(),
            iconColor: AppColors.iconColor1),
        IconAndText(
            icon: Icons.star,
            text: stars.toString(),
            iconColor: AppColors.mainColor),
        IconAndText(
            icon: Icons.location_on,
            text: location!,
            iconColor: AppColors.iconColor2),
      ],
    );
  }
}
