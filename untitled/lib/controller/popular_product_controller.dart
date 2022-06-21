import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/controller/cart_controller.dart';

import 'package:get/get.dart';
import 'package:untitled/model/Product.dart';
import 'package:untitled/model/product_model.dart';
import 'package:untitled/utils/colors.dart';

import '../model/cart_model.dart';


class PopularProductController extends GetxController {
  List<ProductModel> _popularProductList = [];

  int _quantity =0;
  //private var setter for Popularproduct
  List<ProductModel> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int get quantity => _quantity;
  int _inCartItem=0;
  int get inCartItem => _inCartItem + _quantity;

  //-------------------------------------------------------------
  late ProductModel productModel;
  Future<void> getPopularProductList() async {
    List<ProductModel> newList = [];
    //Get in PopularProductrPro
    QuerySnapshot value = await FirebaseFirestore.instance.collection("products").get();
    //200 is ok
    if (value.docs != null) {
      //init to null , no will it repeat
      _popularProductList = [];
      value.docs.forEach((element) {
        //print(element.data());
        //element.data() QueryDocumentSnapshot<T>
        productModel = ProductModel.fromJson(element.data() as Map<String,dynamic>);
        newList.add(productModel);
      },);
      _popularProductList = newList;
      _isLoaded = true;
      update(); //setState
    }
    else {
      print('could not get product');
    }
  }


  void setQuantity(bool inIncrement){
    if(inIncrement){
      //increment quantity
      _quantity = checkQuantity(_quantity+1);
      //print("number of item " + _quantity.toString());
    }
    else{
      _quantity = checkQuantity(_quantity-1);
      //print("decrement " + _quantity.toString());
    }
    update();
  }

  int checkQuantity(int quantity){
    if((_inCartItem + quantity) < 0){
      Get.snackbar("Nhắc nhở", "Không thể giảm thêm !",
      backgroundColor: AppColors.mainColor,

      colorText: Colors.white,
      duration: Duration(seconds: 2));
      if(_inCartItem > 0){
        _quantity = -_inCartItem;
        return _quantity;
      }
      return 0;
    }
    else if((_inCartItem + quantity) > 20){
      Get.snackbar("Nhắc nhở", "Vượt quá số lượng có thể thêm !",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
          duration: Duration(seconds: 2));
      return 20;
    }
    else {
      return quantity;
    }
  }

  void initProduct(ProductModel product,CartController cart){
    _quantity = 0;
    _inCartItem = 0;
    _cart =cart;
    var exist = false;
    exist = _cart.existInCart(product);
    //if exist
    //get from storage _inCartItems = 3
    print("Exits or not " + exist.toString());
    if(exist){
      _inCartItem = _cart.getQuantity(product);

    }
    print('the quantity in the cart is ' + _inCartItem.toString());
  }

  void addItem(ProductModel product){
      _cart.addItem(product, _quantity);


      _quantity=0;
      _inCartItem=_cart.getQuantity(product);

      _cart.items.forEach((key, value) {
        print("The id is " + value.id.toString() + " quantity is " + value.quantity.toString());
      });
      update();
    }

    //get totalItem in cart
    int get totalItem{
    return _cart.totalItems;
    }

    List<CartModel> get getItems{
    return _cart.getItems;
    }
}