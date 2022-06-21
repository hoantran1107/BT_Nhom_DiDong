import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/model/product_model.dart';

class CartModel{
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExit;
  String? time;
  ProductModel? product;

  CartModel(
      {this.id,
        this.name,
        this.price,
        this.img,
        this.quantity,
        this.time,
        this.isExit,
        this.product
        });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    time = json['time'];
    isExit = json['isExit'];
    product = ProductModel.fromJson(json['product']);
      }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'price': this.price ,
      'img': this.img ,
      'quantity': this.quantity ,
      'isExit': this.isExit ,
      'time': this.time ,
      'product': product!.toJson() ,
    };
  }


}