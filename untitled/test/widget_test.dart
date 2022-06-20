// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:untitled/main.dart';
import 'package:untitled/model/Product.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    late ProdProducts productModel;
    List<ProdProducts> newList = [];
    List<ProdProducts> truyenCuoiDS = [];
    QuerySnapshot value =
    await FirebaseFirestore.instance.collection("food").get();

    value.docs.forEach((element) {
       print(element.data());
      productModel = ProdProducts(
        name: element.get("name"),
        brand: element.get("brand")
      );
      newList.add(productModel);
    },);
    truyenCuoiDS = newList;
    });
  }

