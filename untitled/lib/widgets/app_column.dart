

import 'package:flutter/material.dart';
import 'package:untitled/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimentions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;

  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,size: Dimentions.font26,),
        SizedBox(height: Dimentions.height10,),
        Row(
          children: [
            //Same thing together
            Wrap(
              children:
              List.generate(5,(index) {return Icon(Icons.star,color: AppColors.mainColor,size: Dimentions.height15,);})
              ,
            ),
            SizedBox(width: Dimentions.width10,),
            SmallText(text: '4.5'),
            SizedBox(width: Dimentions.width10,),
            SmallText(text: "1287"),
            SizedBox(width: Dimentions.width10,),
            SmallText(text: 'comments')
          ],
        ),
        SizedBox(height: Dimentions.height20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndText(
                icon: Icons.circle_sharp,
                text: 'Normal',
                iconColor: AppColors.iconColor1),
            IconAndText(
                icon: Icons.location_on,
                text: '1.7 km',
                iconColor: AppColors.mainColor),
            IconAndText(
                icon: Icons.access_time_rounded,
                text: '32 min',
                iconColor: AppColors.iconColor2),
          ],
        )
      ],
    );
  }
}
