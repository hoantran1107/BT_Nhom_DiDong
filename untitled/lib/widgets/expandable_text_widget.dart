

import 'package:flutter/material.dart';
import 'package:untitled/utils/colors.dart';
import 'package:untitled/utils/dimentions.dart';
import 'package:untitled/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({
    Key? key,
    required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  //show ui later
  late String firstHalf;
  late String secoundHalf;

  bool hiddenText= true;

  double textHeight = Dimentions.screenHeight/5.63;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.text.length > textHeight){
      firstHalf = widget.text.substring(0,textHeight.toInt());
      secoundHalf = widget.text.substring(textHeight.toInt()+1 , widget.text.length);
    }
    else {
      firstHalf = widget.text;
      secoundHalf = "";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secoundHalf.isEmpty ? SmallText(color: AppColors.paraColor,text: firstHalf,size: Dimentions.font16,) : Column(
        children: [
          SmallText(height:1.5,color: AppColors.paraColor,text: hiddenText ? (firstHalf + "...") : (firstHalf + secoundHalf),size: Dimentions.font16,),
          InkWell(
            onTap: () {
              setState(() {
                hiddenText =! hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(text: hiddenText? 'Show more' :'Show less' , color: AppColors.mainColor,size: Dimentions.font16,),
                Icon(hiddenText? Icons.arrow_drop_down : Icons.arrow_drop_up ,color: AppColors.mainColor,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
