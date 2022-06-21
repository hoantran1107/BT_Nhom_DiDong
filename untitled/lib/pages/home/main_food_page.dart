

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/utils/colors.dart';
import 'package:untitled/utils/dimentions.dart';
import 'package:untitled/widgets/big_text.dart';
import 'package:untitled/widgets/small_text.dart';

import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    //Header Section
    return Scaffold(
      body: Column(
        children: [
          //showing the header
          Container(
          child: Container(
            margin: EdgeInsets.only(top: Dimentions.height45,bottom: Dimentions.height15),
            padding: EdgeInsets.only(left: Dimentions.width20,right: Dimentions.width20),
            child: Row(
              //1 on the left and 1 on the right
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text: 'Việt Nam',color:AppColors.mainColor),
                    Row(
                        children: [
                          SmallText(text: 'Nha Trang', color: Colors.black54,),
                          Icon(Icons.arrow_drop_down_rounded,size: Dimentions.iconSize24,)
                        ] )
                  ],
                ),
                Center(
                  child: Container(
                    width: Dimentions.width45,
                    height: Dimentions.height45,
                    child: Icon(Icons.search, color:Colors.white),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimentions.radius15),
                      color: AppColors.mainColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
          //showing body
          Expanded(child: SingleChildScrollView(
              child: FoodPageBody()))
      ],)
    );
  }
}
