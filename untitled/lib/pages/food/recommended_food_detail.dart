import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled/controller/popular_product_controller.dart';
import 'package:untitled/controller/recommended_product_controller.dart';
import 'package:untitled/model/Product.dart';
import 'package:untitled/pages/cart/cart_page.dart';
import 'package:untitled/route/router_helper.dart';
import 'package:untitled/utils/colors.dart';
import 'package:untitled/utils/dimentions.dart';
import 'package:untitled/widgets/app_icon.dart';
import 'package:untitled/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';
import '../../controller/cart_controller.dart';
import '../../utils/app_containt.dart';
import '../../widgets/big_text.dart';
class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail({Key? key,
    required this.pageId,
    required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    //initialLizile Cart Controller
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        //sliver for specail efects
        slivers: [
          //list of sliver
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 100,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      if(page == 'cartpage'){
                        Get.toNamed(RouteHelper.getCartPage());
                      }else {
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(icon: Icons.clear)),
                GetBuilder<PopularProductController>(
                  builder: (controller) {
                    return Badge(
                      showBadge: controller.totalItem >= 1,
                      badgeContent:Text("${Get.find<PopularProductController>().totalItem}"
                      ),
                      animationType: BadgeAnimationType.slide,
                      badgeColor: AppColors.mainColor,
                      child: GestureDetector(
                        onTap: () {
                          if(controller.totalItem >= 1)
                          Get.toNamed(RouteHelper.getCartPage());
                        },
                        child: AppIcon(
                          icon: Icons.shopping_cart_outlined,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              //Appbar scoll Widget
              child: Container(
                child: Center(
                    child: BigText(text:'${product.name}',size: Dimentions.font26,)
                ),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5,bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimentions.radius20),
                    topRight: Radius.circular(Dimentions.radius20),
                  ),
                  color:Colors.white,
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            //disable Appbar
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                  product.img!,
              width: double.maxFinite,
              fit: BoxFit.cover,),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableTextWidget(
                      text:product.description!),
                  margin: EdgeInsets.only(left: Dimentions.width20,right: Dimentions.width20),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          return  Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: Dimentions.width20*2.5,
                    right: Dimentions.width20*2.5,
                    top: Dimentions.height10,
                    bottom: Dimentions.height10
                ),
                child: Row(
                  mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                          iconSize: Dimentions.iconSize24,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          icon: Icons.remove),
                    ),
                    BigText(text: "\$ ${product.price!} X ${controller.inCartItem}",color: AppColors.mainBlackColor,size: Dimentions.font26,),
                    GestureDetector(
                      onTap: () {
                          controller.setQuantity(true);
                      },
                      child: AppIcon(
                          iconSize: Dimentions.iconSize24,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          icon: Icons.add),
                    ),
                  ],
                ),
              ),
              Container(
                height: Dimentions.bottomHeightBar,
                padding: EdgeInsets.only(top: Dimentions.height20,bottom: Dimentions.height20,left: Dimentions.width20,right: Dimentions.width20),
                decoration: BoxDecoration(
                    color: AppColors.buttonBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimentions.radius20*2),
                      topRight: Radius.circular(Dimentions.radius20*2),
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: Dimentions.height20,bottom: Dimentions.height20,left: Dimentions.width20,right: Dimentions.width20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimentions.radius20),
                            color: Colors.white
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: AppColors.mainColor,
                        )
                    ),
                    Container(
                      padding: EdgeInsets.only(top: Dimentions.height20,bottom: Dimentions.height20,left: Dimentions.width20,right: Dimentions.width20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimentions.radius20),
                        color: AppColors.mainColor,
                      ),
                      child: GestureDetector
                        (
                          onTap: () {
                            controller.addItem(product);
                          },
                          child: BigText(text: '\$${product.price!} | Thêm vào giỏ hàng',
                            color: Colors.white,)),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      )
    );
  }
}





/*
//Testing FireBase
class RecommendedFoodDetail2 extends StatelessWidget {
  ProdProducts product;
  RecommendedFoodDetail2({Key? key,required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        //sliver for specail efects
        slivers: [
          //list of sliver
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 100,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.clear)),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              //Appbar scoll Widget
              child: Container(
                child: Center(
                    child: BigText(text:'${product.name}',size: Dimentions.font26,)
                ),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5,bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimentions.radius20),
                    topRight: Radius.circular(Dimentions.radius20),
                  ),
                  color:Colors.white,
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            //disable Appbar
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                product.productImage!,
                width: double.maxFinite,
                fit: BoxFit.cover,),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableTextWidget(
                      text:product.desc!),
                  margin: EdgeInsets.only(left: Dimentions.width20,right: Dimentions.width20),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: Dimentions.width20*2.5,
                right: Dimentions.width20*2.5,
                top: Dimentions.height10,
                bottom: Dimentions.height10
            ),
            child: Row(
              mainAxisAlignment:  MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                    iconSize: Dimentions.iconSize24,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    icon: Icons.remove),
                BigText(text: "\$ ${product.price!} X 0",color: AppColors.mainBlackColor,size: Dimentions.font26,),
                GestureDetector(
                  onTap: () {
                    print(" i tap aaaaaaaa");
                  },
                  child: AppIcon(
                      iconSize: Dimentions.iconSize24,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      icon: Icons.add),
                ),
              ],
            ),
          ),
          Container(
            height: Dimentions.bottomHeightBar,
            padding: EdgeInsets.only(top: Dimentions.height20,bottom: Dimentions.height20,left: Dimentions.width20,right: Dimentions.width20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimentions.radius20*2),
                  topRight: Radius.circular(Dimentions.radius20*2),
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.only(top: Dimentions.height20,bottom: Dimentions.height20,left: Dimentions.width20,right: Dimentions.width20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimentions.radius20),
                        color: Colors.white
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    )
                ),
                Container(
                  padding: EdgeInsets.only(top: Dimentions.height20,bottom: Dimentions.height20,left: Dimentions.width20,right: Dimentions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimentions.radius20),
                    color: AppColors.mainColor,
                  ),
                  child: BigText(text: '\$${product.price!} | Add to cart',color: Colors.white,),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/
