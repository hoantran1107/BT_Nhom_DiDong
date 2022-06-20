import 'package:get/get.dart';
import 'package:untitled/controller/cart_controller.dart';
import 'package:untitled/controller/popular_product_controller.dart';
import 'package:untitled/controller/recommended_product_controller.dart';
import 'package:untitled/data/api/api_client.dart';
import 'package:untitled/data/repository/cart_repo.dart';
import 'package:untitled/utils/app_containt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/Product.dart';

Future<void> init() async {
  //load sharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  //load api client
  Get.lazyPut(() => ApiClient(appBaseUrl:AppConstants.BASE_URL));

  //repos
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  //controllers
  Get.lazyPut(() => PopularProductController());
  Get.lazyPut(() => RecommendedProductController());
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  //Firebase
}