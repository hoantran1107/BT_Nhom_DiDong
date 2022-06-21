import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/data/repository/cart_repo.dart';
import 'package:untitled/model/product_model.dart';
import 'package:untitled/utils/colors.dart';

import '../model/cart_model.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
  Map<int,CartModel> _items={};
   CartController({
    required this.cartRepo,
  });

  Map<int , CartModel> get items => _items;
  /*
  only for storage and sharedprefrence
   */
  List<CartModel> storageItems = [];

   void addItem(ProductModel product, int quantity){
       //print("Length of the item is " + _items.length.toString());
       //if exits do not add product
       //check for key contain
     var toltalQuantity = 0;
        if(_items.containsKey(product.id!)){
          _items.update(product.id!, (value) {
            //all object
            toltalQuantity = value.quantity! + quantity;


            return CartModel(
                id: value.id,
                name: value.name,
                price: value.price,
                img: value.img,
                quantity: value.quantity! + quantity,
                time: DateTime.now().toString(),
                isExit: true,
                product: product);
          });

          if(toltalQuantity <= 0){
            items.remove(product.id);
          }
        }
        else {
          if(quantity > 0){
            _items.putIfAbsent(product.id!, () {
              print('adding item to the cart id' + product.id.toString() +
                  " quantity " + quantity.toString());
              return CartModel(
                  id: product.id,
                  name: product.name,
                  price: product.price,
                  img: product.img,
                  quantity: quantity,
                  time: DateTime.now().toString(),
                  isExit: true,
                  product: product
              );
            });
          }
          else{
              Get.snackbar("Nhắc nhở", "Bạn phải thêm ít nhất 1 sản phẩm vào giỏ hàng !",
                  backgroundColor: AppColors.mainColor,
                  colorText: Colors.white,
                  duration: Duration(seconds: 2));
            }
        }
        cartRepo.addToCartList(getItems);
        update();

   }

   bool existInCart(ProductModel product){
     if(_items.containsKey(product.id)){
       return true;
     }
     return false;
   }

   getQuantity(ProductModel product){
     var quantity = 0;
     if(_items.containsKey(product.id)){
       _items.forEach((key, value) {
         if(key == product.id){
           quantity = value.quantity!;
         }
       });
     }
     return quantity;
   }

   int get totalItems{
     var totalQuantity = 0;
     _items.forEach((key, value) {
       totalQuantity +=  value.quantity!;
     });
     return totalQuantity;
   }

   //get a list of CartModel
   List<CartModel> get getItems{
     //entries get a map
     return _items.entries.map((e) {
       return e.value;
     },).toList();
   }

   int get totaAmout{
     var total = 0;
     _items.forEach((key, value) {
       total +=  value.quantity!*value.price!;
     });
     return total;
   }

   List<CartModel> getCartData(){
    setCart = cartRepo.getCartList();
     return storageItems;
   }

   set setCart(List<CartModel> items){
      storageItems = items;

      for(int i= 0 ; i<storageItems.length ; i++){
        _items.putIfAbsent(storageItems[i].product!.id!,
                () => storageItems[i]);
      }
   }

   void addToHistory(){
     cartRepo.addToCartHistoryList();
     clear();
   }

   void clear(){
     _items={};
     update();
   }

   List<CartModel> getCartHistoryList(){
     return cartRepo.getCartHistoryList();
   }

   set setItems(Map<int, CartModel> setItems){
     _items={};
     _items=setItems;
   }
   void addToCartList(){
     cartRepo.addToCartList(getItems);
     update();
   }
}