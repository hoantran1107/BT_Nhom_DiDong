

import 'package:flutter/material.dart';
import 'package:untitled/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimentions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final int star;

  const AppColumn({Key? key, required this.text,required this.star}) : super(key: key);

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
              List.generate(star,(index) {
                return Icon(Icons.star,color: AppColors.mainColor,size: Dimentions.height15,);})
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
      ],
    );
  }
}
