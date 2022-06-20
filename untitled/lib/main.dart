import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:untitled/controller/cart_controller.dart';
import 'package:untitled/controller/popular_product_controller.dart';
import 'package:untitled/controller/recommended_product_controller.dart';
import 'package:untitled/pages/home/home_page.dart';
import 'package:untitled/pages/home/main_food_page.dart';
import 'package:untitled/pages/splash/splash_page.dart';
import 'package:untitled/route/router_helper.dart';
import 'helper/dependencies.dart' as dep;
Future<void> main() async{
  //make sure dependenc load correctly
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_){
        return GetBuilder<RecommendedProductController>(builder: (_) {
             return GetMaterialApp(
              //List of Page that in program
              getPages: RouteHelper.route,
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              initialRoute: RouteHelper.getSplashPage(),
            );
        },);
      },
    );
  }
}
