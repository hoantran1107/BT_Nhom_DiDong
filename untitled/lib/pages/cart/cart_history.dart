  import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:untitled/base/no_data_page.dart';
  import 'package:untitled/controller/recommended_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:untitled/controller/cart_controller.dart';
import 'package:untitled/model/cart_model.dart';
import 'package:untitled/route/router_helper.dart';
import 'package:untitled/utils/app_containt.dart';
import 'package:untitled/utils/colors.dart';
import 'package:untitled/utils/dimentions.dart';
import 'package:untitled/widgets/app_icon.dart';
import 'package:untitled/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:untitled/widgets/small_text.dart';
class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList= Get.find<CartController>()
        .getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder=Map();
    for(int i=0;i<getCartHistoryList.length;i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!,()=>1);
      }
    }

    List<int> cartItemsPerOrderToList(){
      return cartItemsPerOrder.entries.map((e)=>e.value).toList();
    }
    List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e)=>e.key).toList();
    }
    List<int> itemsPerOrder=cartItemsPerOrderToList();
    var ListCounter=0;
   Widget timeWidget(int index){
     var outputDate=DateTime.now().toString();
      if(index<getCartHistoryList.length){
        DateTime parseDate= DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[ListCounter].time! );
        var inputDate=DateTime.parse(parseDate.toString());
        var outputFormat= DateFormat("dd/MM/yyyy hh:mm a");
        outputDate=outputFormat.format(inputDate);
      }
      return BigText(text:outputDate);
    }
    return Scaffold(

      // appBar: AppBar(
      //   actions: [
      //     Icon(Icons.shopping_cart)
      //   ],
      //   title: Center(child: BigText(text: "Lịch Sử Giao Dịch",)),
      //),
      body:Column(
        children: [
          Container(
            height: Dimentions.height10*10,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top:Dimentions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Lịch sử giao dịch",color: Colors.white,),
                AppIcon(icon: Icons.shopping_cart_outlined,iconColor: AppColors.mainColor,
                  backgroundColor: AppColors.yellowColor,
                )
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getCartHistoryList().length>0?
            Expanded(child: Container(
                  margin: EdgeInsets.only(
                      top: Dimentions.height20,
                      left: Dimentions.width20,
                      right: Dimentions.width20
                  ),
                  child:MediaQuery.removePadding(
                      removeTop: true,
                      context: context, child: ListView(
                    children: [
                      for(int i=0;i<itemsPerOrder.length;i++)
                        Container(
                          height: Dimentions.height30*4,
                          margin: EdgeInsets.only(bottom: Dimentions.height20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              timeWidget(ListCounter),
                              SizedBox(height: Dimentions.height10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(itemsPerOrder[i], (index){
                                      if(ListCounter<getCartHistoryList.length){
                                        ListCounter++;
                                      }
                                      return index<=2?Container(
                                        height: Dimentions.height20*4,
                                        width: Dimentions.height20*4,
                                        margin: EdgeInsets.only(right: Dimentions.width10/2),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimentions.radius15/2),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    getCartHistoryList[ListCounter-1].img!
                                                )
                                            )
                                        ),
                                      ):Container();
                                    }),
                                  ),
                                  Container(
                                    height: Dimentions.height20*4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [

                                        SmallText(text: "Tổng cộng",color: AppColors.titleColor),
                                        BigText(text: itemsPerOrder[i].toString()+" Sản phẩm",color: AppColors.titleColor,),
                                        GestureDetector(
                                          onTap: (){
                                            var orderTime=cartOrderTimeToList();
                                            Map<int, CartModel> moreOrder={};
                                            for(int j=0;j<getCartHistoryList.length;j++){
                                              if(getCartHistoryList[j].time==orderTime[i]){
                                                moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                    CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                                );
                                              }
                                            }
                                            Get.find<CartController>().setItems= moreOrder;
                                            Get.find<CartController>().addToCartList();
                                            Get.toNamed(RouteHelper.getCartPage());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: Dimentions.width10,vertical: Dimentions.height10/2),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimentions.radius15/3),
                                              border: Border.all(width: 1, color: AppColors.mainColor),
                                            ),
                                            child: SmallText(text: "Hơn 1+",color: AppColors.mainColor,),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                    ],
                  )),
                )):
            SizedBox(
              height: MediaQuery.of(context).size.height/1.5,
                child: const Center(
                  child: NoDataPage(
                    text: "Lịch Sử Giao Dịch Trống",
                    imgPath: "assets/image/empty_box.png",),
                ));
          })
        ],
      ),
    );
  }
}
