import 'package:get/get.dart';
import 'package:untitled/model/Product.dart';
import 'package:untitled/pages/cart/cart_history.dart';
import 'package:untitled/pages/food/popular_food_detail.dart';
import 'package:untitled/pages/food/recommended_food_detail.dart';
import 'package:untitled/pages/home/home_page.dart';
import 'package:untitled/pages/home/main_food_page.dart';
import 'package:untitled/pages/splash/splash_page.dart';

import '../pages/cart/cart_page.dart';

class RouteHelper{
  static const String splashPage = '/splash-page';
  static const String initial='/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cartPage = '/cart-page';
  static const String popularDog = '/dog-page';
  static const String history='/';
  //Test firebase
  static const String recommendedFood2 = '/recommended2-food';
  //Function
  static String getSplashPage()=> '$splashPage';
  static String getInitial ()=> '$initial';
  static String getCartHistory()=>'$history';
  static String getPopularFood(int pageId,String page)=> '$popularFood?pageId=$pageId&page=$page';
  static String getPopularDog(int pageId,String page)=> '$popularDog?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId,String page)=> '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage()=> cartPage;
  //List of page route
  //defind for page
  static List<GetPage> route=[
    GetPage(name: splashPage, page: () => const SplashPage(),
        transition: Transition.fadeIn),
    GetPage(name: initial, page: () => const HomePage(),
    transition: Transition.fadeIn),
    GetPage(name: history, page: ()=>const CartHistory(),
    transition: Transition.fadeIn),
    GetPage(
        name: popularDog,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetail(pageId: int.parse(pageId!),page:page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetail(pageId: int.parse(pageId!),page:page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetail(pageId: int.parse(pageId!),page:page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn),
  ];
}