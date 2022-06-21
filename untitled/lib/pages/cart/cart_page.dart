import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/base/no_data_page.dart';
import 'package:untitled/controller/cart_controller.dart';
import 'package:untitled/controller/popular_product_controller.dart';
import 'package:untitled/controller/recommended_product_controller.dart';
import 'package:untitled/model/cart_model.dart';
import 'package:untitled/pages/home/main_food_page.dart';
import 'package:untitled/route/router_helper.dart';
import 'package:untitled/utils/app_containt.dart';
import 'package:untitled/utils/colors.dart';
import 'package:untitled/utils/dimentions.dart';
import 'package:untitled/widgets/app_icon.dart';
import 'package:untitled/widgets/big_text.dart';
import 'package:untitled/widgets/small_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          Positioned(
              top:Dimentions.height20*3,
              left: Dimentions.width20,
              right: Dimentions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 GestureDetector(
                   onTap: () {
                     Get.toNamed(RouteHelper.initial);
                   },
                   child: AppIcon(icon: Icons.arrow_back_ios,
                   iconColor: Colors.white,
                   backgroundColor: AppColors.mainColor,
                   iconSize: Dimentions.iconSize24,),
                 ),
                 SizedBox(width: Dimentions.width20*5,),
                 GestureDetector(
                   onTap: () {
                     Get.toNamed(RouteHelper.getInitial());
                   },
                   child: AppIcon(icon: Icons.home_outlined,
                     iconColor: Colors.white,
                     backgroundColor: AppColors.mainColor,
                     iconSize: Dimentions.iconSize24,),
                 ),
                 GestureDetector(
                   onTap: (){
                     Get.toNamed(RouteHelper.history);
                   },
                 child: AppIcon(icon: Icons.shopping_cart,
                   iconColor: Colors.white,
                   backgroundColor: AppColors.mainColor,
                   iconSize: Dimentions.iconSize24,
                 ),
                 )
               ],
              )),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length>0? Positioned(
                left: Dimentions.width20,
                top: Dimentions.height20*5,
                right: Dimentions.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimentions.height15),
                  //color: AppColors.mainColor,
                  //RemovePadding
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: GetBuilder<CartController>(
                        builder: (controller) {
                          var _cartList = controller.getItems;
                          return ListView.builder(
                            itemCount: _cartList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: Dimentions.height20*5,
                                //take all space avalable
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        var popularIndex = Get.find<PopularProductController>()
                                            .popularProductList
                                            .indexOf(_cartList[index].product!);

                                        if(popularIndex>=0){
                                          Get.toNamed(RouteHelper.getPopularFood(popularIndex,'cartpage'));
                                        }
                                        else {
                                          var recommendIndex = Get.find<RecommendedProductController>()
                                              .recommendedProductList
                                              .indexOf(_cartList[index].product!);
                                          if(recommendIndex<0){
                                            Get.snackbar("Nhắc nhở", "Bạn không thể xem chi tiết sản phẩm ở đây !",
                                                backgroundColor: AppColors.mainColor,
                                                colorText: Colors.white,
                                                duration: Duration(seconds: 2));
                                          }else{
                                            Get.toNamed(RouteHelper.getRecommendedFood(recommendIndex,"cartpage"));
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: Dimentions.height20*5,
                                        height: Dimentions.height20*5,
                                        margin: EdgeInsets.only(bottom: Dimentions.height10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimentions.radius20),
                                            color: Colors.white,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  controller.getItems[index].img!
                                              ),
                                            )
                                        ),

                                      ),
                                    ),
                                    SizedBox(width: Dimentions.width10,),
                                    //Container inside Expnaded take all avalable size of parent Container is Row
                                    Expanded(
                                        child: Container(
                                          height: Dimentions.height20*50,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BigText(text: _cartList[index].name!,color: Colors.black54,),
                                              SmallText(text: "spicy"),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  BigText(text: "\$ ${_cartList[index].price}",color: Colors.redAccent,),
                                                  //
                                                  Container(
                                                    padding: EdgeInsets.only(top: Dimentions.height10,
                                                        bottom: Dimentions.height10,
                                                        left: Dimentions.width10,
                                                        right: Dimentions.width10),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimentions.radius20),
                                                        color: Colors.white
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                            onTap: () {
                                                              controller.addItem(_cartList[index].product!, -1);
                                                            },
                                                            child: Icon(
                                                                Icons.remove, color: AppColors.signColor)),
                                                        SizedBox(width: Dimentions.width10 / 2,),
                                                        BigText(text: _cartList[index].quantity.toString()),//popularProduct.inCartItem.toString()),
                                                        SizedBox(width: Dimentions.width10 / 2,),
                                                        GestureDetector(
                                                            onTap: () {
                                                              print('tap tap');
                                                              controller.addItem(_cartList[index].product!, 1);
                                                            },
                                                            child: Icon(Icons.add, color: AppColors.signColor)),
                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              )
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              );
                            },);
                        },
                      )
                  ),
                )
            ):NoDataPage(text: "Giỏ Hàng Trống");
          })
         ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
          builder: (controller) {
            return Container(
              height: Dimentions.bottomHeightBar,
              padding: EdgeInsets.only(top: Dimentions.height20,
                  bottom: Dimentions.height20,
                  left: Dimentions.width20,
                  right: Dimentions.width20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimentions.radius20 * 2),
                    topRight: Radius.circular(Dimentions.radius20 * 2),
                  )
              ),
              child: controller.getItems.length>0?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: Dimentions.height20,
                      bottom: Dimentions.height20,
                      left: Dimentions.width20,
                      right: Dimentions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimentions.radius20),
                      color: Colors.white
                  ),
                  child: Row(
                    children: [

                      SizedBox(width: Dimentions.width10 / 2,),
                      BigText(text:'\$ ${controller.totaAmout.toString()}'),// popularProduct.inCartItem.toString()),
                      SizedBox(width: Dimentions.width10 / 2,),

                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // popularProduct.addItem(product);
                    controller.addToHistory();
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimentions.height20,
                        bottom: Dimentions.height20,
                        left: Dimentions.width20,
                        right: Dimentions.width20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimentions.radius20),
                        color: AppColors.mainColor
                    ),
                    child: BigText(text:"Thanh Toán", //'\$${product.price} | Add to cart',
                      color: Colors.white,),
                  ),
                )
              ],
            ):Container(),
            );
          }
      ),
    );
  }
}
