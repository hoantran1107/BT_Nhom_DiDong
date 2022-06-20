import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled/route/router_helper.dart';
import 'package:untitled/utils/dimentions.dart';

import '../../controller/popular_product_controller.dart';
import '../../controller/recommended_product_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;
  Future<void> _loadResource() async{
    //load Rescource for
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  void initState() {
    // TODO: implement initState
    /*
     A.. create instance form that instance use that function
     */
    super.initState();
    _loadResource();
    controller = AnimationController(
        vsync: this,
        duration:  const Duration(seconds: 2))..forward();
    animation = CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutExpo);
    Timer(
      Duration(seconds: 3),
      () => Get.offNamed(RouteHelper.getInitial()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
                child: Image.asset("assets/images/petshop-footprint-logo-transBg.png",
                  width: Dimentions.splashImg,)),
          ),
          Center(
              child: Image.asset("assets/images/petshop-logo-transBg.png",
                width: Dimentions.splashImg,)),
        ],
      ),
    );
  }
}
