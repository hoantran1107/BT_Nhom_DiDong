import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled/controller/popular_product_controller.dart';
import 'package:untitled/controller/recommended_product_controller.dart';
import 'package:untitled/model/Product.dart';
import 'package:untitled/model/product_model.dart';
import 'package:untitled/pages/food/popular_food_detail.dart';
import 'package:untitled/pages/food/recommended_food_detail.dart';
import 'package:untitled/route/router_helper.dart';
import 'package:untitled/utils/colors.dart';
import 'package:untitled/utils/dimentions.dart';
import 'package:untitled/widgets/app_column.dart';
import 'package:untitled/widgets/big_text.dart';
import 'package:untitled/widgets/icon_and_text_widget.dart';
import 'package:untitled/widgets/small_text.dart';

import '../../utils/app_containt.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue=0.0;
  double _scaleFactor = 0.8;
  double _height = Dimentions.pageViewContainer;
  @override
  void initState() {
    //inside stful class
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue= pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    //leave the page left memory free
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        // StreamBuilder<List<ProdProductsSnapshot>>(
        //     builder: (context, snapshot) {
        //       return snapshot.hasData ?
        //       Container(
        //         //color: Colors.redAccent,
        //         height: Dimentions.pageView,
        //         child: PageView.builder(
        //           controller: pageController,
        //           itemCount: snapshot.data!.length,
        //           itemBuilder: (context, position) {
        //             return _buildPageItem(position,snapshot.data![position].products!);
        //           },
        //         ),
        //       )
        //           : CircularProgressIndicator(
        //         color: AppColors.mainColor,
        //       );
        //     },
        //     stream: ProdProductsSnapshot.getAllProduct(),
        //
        // ),
        /* Firebase */
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return popularProducts.isLoaded ?
            Container(
              //color: Colors.redAccent,
              height: Dimentions.pageView,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  itemBuilder: (context, position) {
                    return _buildPageItem(position,popularProducts.popularProductList[position]);
                  },
                ),
            )
                : CircularProgressIndicator(
              color: AppColors.mainColor,
            );
          }

        ),
        /*dots*/
        GetBuilder<PopularProductController>(builder: (popularproduct) {
          return DotsIndicator(
            dotsCount: popularproduct.popularProductList.length <= 0 ? 1 : popularproduct.popularProductList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        //Popular text
        SizedBox(height: Dimentions.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimentions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Khuyên Dùng"),
              SizedBox(width: Dimentions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: '.',color: Colors.black26,),
              ),
              SizedBox(width: Dimentions.width10,),
              Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: SmallText(text: 'Thức ăn cho thú cưng'))
            ],
          ),
        ),
        //Recommend Food
        StreamBuilder<List<ProdProductsSnapshot>>(
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return  GetBuilder<RecommendedProductController>(
                  builder: (recommendedProduct)
                  {
                    var A = snapshot.data;
                    return recommendedProduct.isLoaded ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: A!.length,
                      shrinkWrap: true,
                      // itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getRecommendedFood(index,""));
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: Dimentions.width20,right: Dimentions.width20 , bottom:Dimentions.height10),
                            child: Row(
                              children: [
                                //image section
                                Container(
                                  width:Dimentions.listViewImgSize,
                                  height: Dimentions.listViewImgSize,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimentions.radius20),
                                      color: Colors.white,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            //recommendedProduct.recommendedProductList[index].img!
                                              A[index].products!.img!
                                          )
                                      )
                                  ),
                                ),
                                //text container
                                Expanded(
                                  child: Container(
                                    height: Dimentions.listViewImgSize,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(Dimentions.radius20),
                                            bottomRight: Radius.circular(Dimentions.radius20)
                                        ),
                                        color: Colors.white10
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: Dimentions.width10,right: Dimentions.width10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          BigText(
                                              text: A[index].products!.name!
                                            //recommendedProduct.recommendedProductList[index].name!
                                          )
                                          ,
                                          SizedBox(height: Dimentions.height10,),
                                          BigText(
                                            text:A[index].products!.description!
                                            //recommendedProduct.recommendedProductList[index].description!
                                            ,size: 12,color: AppColors.mainBlackColor,),
                                          SizedBox(height: Dimentions.height10,),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ) : CircularProgressIndicator(
                      color: AppColors.mainColor,
                    );
                  });
            }
            else
              {
                print(snapshot.error.toString());
                return CircularProgressIndicator();
              }
          },
          stream: ProdProductsSnapshot.getAllProduct(),
        ),
        /*Testting FiresBase */
        // StreamBuilder<List<ProdProductsSnapshot>>(
        //     builder:(context, snapshot) {
        //       return snapshot.hasData ? ListView.builder(
        //         physics: const NeverScrollableScrollPhysics(),
        //         itemCount: snapshot.data!.length,
        //         shrinkWrap: true,
        //         // itemCount: snapshot.data!.length,
        //         itemBuilder: (context, index) {
        //           return GestureDetector(
        //             onTap: () {
        //               Get.to(RecommendedFoodDetail2(product: snapshot.data![index].products!));
        //             },
        //             child: Container(
        //               margin: EdgeInsets.only(left: Dimentions.width20,right: Dimentions.width20 , bottom:Dimentions.height10),
        //               child: Row(
        //                 children: [
        //                   //image section
        //                   Container(
        //                     width:Dimentions.listViewImgSize,
        //                     height: Dimentions.listViewImgSize,
        //                     decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.circular(Dimentions.radius20),
        //                         color: Colors.white,
        //                         image: DecorationImage(
        //                             fit: BoxFit.cover,
        //                             image: NetworkImage(
        //                                 snapshot.data![index].products!.productImage!
        //                             )
        //                         )
        //                     ),
        //                   ),
        //                   //text container
        //                   Expanded(
        //                     child: Container(
        //                       height: Dimentions.listViewImgSize,
        //                       decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.only(
        //                               topRight: Radius.circular(Dimentions.radius20),
        //                               bottomRight: Radius.circular(Dimentions.radius20)
        //                           ),
        //                           color: Colors.white10
        //                       ),
        //                       child: Padding(
        //                         padding: EdgeInsets.only(left: Dimentions.width10,right: Dimentions.width10),
        //                         child: Column(
        //                           crossAxisAlignment: CrossAxisAlignment.start,
        //                           mainAxisAlignment: MainAxisAlignment.center,
        //                           children: [
        //                             BigText(text: snapshot.data![index].products!.name!),
        //                             SizedBox(height: Dimentions.height10,),
        //                             BigText(text:snapshot.data![index].products!.desc!,size: 12,color: AppColors.mainBlackColor,),
        //                             SizedBox(height: Dimentions.height10,),
        //                             Row(
        //                               crossAxisAlignment: CrossAxisAlignment.start,
        //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 IconAndText(
        //                                     icon: Icons.circle_sharp,
        //                                     text: 'Normal',
        //                                     iconColor: AppColors.iconColor1),
        //                                 IconAndText(
        //                                     icon: Icons.location_on,
        //                                     text: '1.7 km',
        //                                     iconColor: AppColors.mainColor),
        //                                 IconAndText(
        //                                     icon: Icons.access_time_rounded,
        //                                     text: '32 min',
        //                                     iconColor: AppColors.iconColor2),
        //                               ],
        //                             )
        //                           ],
        //                         ),
        //                       ),
        //                     ),
        //                   )
        //                 ],
        //               ),
        //             ),
        //           );
        //         },
        //       ) : CircularProgressIndicator(
        //           color: AppColors.mainColor,);
        //     },
        //             stream: ProdProductsSnapshot.getAllProduct(),
        //
        //
        //         )

      ],
    );
  }

  Widget _buildPageItem (int index,
      ProductModel popularProduct
      //ProdProducts popularProduct
  ){

    //api matrix4
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }

    //Stack to overwrite widget
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
                Get.toNamed(RouteHelper.getPopularFood(index,"home"));
            },
            child: Container(
              margin: EdgeInsets.only(left: Dimentions.width10,right: Dimentions.width10),
              height: Dimentions.pageViewContainer,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimentions.radius30),
                  color: index.isEven?Color(0xFF69c5df):Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          //popularProduct.productImage!
                         popularProduct.img!
                      )
                  )
              ),
            ),
          ),
          //Align stack widget
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(left: Dimentions.width30,right: Dimentions.width30,bottom: Dimentions.height30),
              height: Dimentions.pageViewTextContainer,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimentions.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0,5)
                    ),
                    BoxShadow(
                        color: Colors.white ,
                        offset: Offset(-5,0)
                    )
                    ,
                    BoxShadow(
                        color: Colors.white ,
                        offset: Offset(5,0)
                    )
                  ]
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimentions.width15,left: Dimentions.width15,right: Dimentions.width15),
                child: AppColumn(text: popularProduct.name!,),
              ),

            ),
          )
        ],
      ),
    );
  }
}
