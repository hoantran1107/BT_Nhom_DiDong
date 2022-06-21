import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/cart_controller.dart';
import 'package:untitled/controller/popular_product_controller.dart';
import 'package:untitled/model/product_model.dart';
import 'package:untitled/pages/cart/cart_page.dart';
import 'package:untitled/pages/home/main_food_page.dart';
import 'package:untitled/route/router_helper.dart';
import 'package:untitled/utils/app_containt.dart';
import 'package:untitled/utils/dimentions.dart';
import 'package:untitled/widgets/app_column.dart';
import 'package:untitled/widgets/app_icon.dart';
import 'package:untitled/widgets/expandable_text_widget.dart';
import 'package:badges/badges.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
   int pageId;
   String page;
  PopularFoodDetail({Key? key,
    required this.pageId,
  required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    //1 instance of Cart
    //initProduct
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      backgroundColor:Colors.white,
      body: Stack(
        children: [
          //Image popular item
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimentions.popularFoodImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                     image: NetworkImage(
                       product.img!
                      )
                  )
                ),
              )),
          //Icon back and cart
          Positioned(
              top: Dimentions.height45,
              left: Dimentions.width20,
              right: Dimentions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if(page == "cartpage") {
                      Get.toNamed(RouteHelper.getCartPage());
                    } else {
                      Get.toNamed(RouteHelper.getInitial());
                    }
                  },
                    child: AppIcon(icon: Icons.arrow_back_ios),

                ),
                //state manager using getx GetBuilder
                GetBuilder<PopularProductController>(
                    builder: (controller) {
                      return GestureDetector(
                        onTap: () {
                          if(controller.totalItem >= 1)
                          Get.toNamed(RouteHelper.getCartPage());
                        },
                        child: Badge(
                          showBadge: controller.totalItem >= 1,
                          badgeContent:Text("${Get.find<PopularProductController>().totalItem}"
                          ),
                          animationType: BadgeAnimationType.slide,
                          badgeColor: AppColors.mainColor,
                          child: AppIcon(
                            icon: Icons.shopping_cart_outlined,
                          ),
                        ),
                      );
                    },
                )
              ],
          )),
          //Introduction of item
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top:Dimentions.popularFoodImgSize-20,
              child: Container(
            padding: EdgeInsets.only(left: Dimentions.width20,right: Dimentions.width20,top: Dimentions.height20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight:Radius.circular(Dimentions.radius20,),
                  topLeft: Radius.circular(Dimentions.radius20)),
              color: Colors.white
            ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!,star: product.stars!),
                    SizedBox(height: Dimentions.height20),
                    BigText(text: 'Introduce'),
                    SizedBox(height: Dimentions.height20),
                    Expanded(
                        child: SingleChildScrollView(
                            child: ExpandableTextWidget(
                            text: product.description!,)
                        )
                          )
                  ],
                )
          )),
          //expandable text widget
        ],
      ),
      //Controller
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
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
            child: Row(
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
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(false);
                          },
                          child: Icon(
                              Icons.remove, color: AppColors.signColor)),
                      SizedBox(width: Dimentions.width10 / 2,),
                      BigText(text: popularProduct.inCartItem.toString()),
                      SizedBox(width: Dimentions.width10 / 2,),
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(true);
                          },
                          child: Icon(Icons.add, color: AppColors.signColor)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    popularProduct.addItem(product);
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
                    child: BigText(text: '\$${product.price}|Thêm vào giỏ',
                      color: Colors.white,),
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
