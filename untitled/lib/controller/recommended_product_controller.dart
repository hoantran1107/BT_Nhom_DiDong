
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:untitled/model/product_model.dart';


class RecommendedProductController extends GetxController {

  List<ProductModel> _recommendedProductList = [];

  //private var setter for Popularproduct
  List<ProductModel> get recommendedProductList => _recommendedProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  late ProductModel productModel;
  Future<void> getRecommendedProductList() async {
    //Get in PopularProductrPro
    List<ProductModel> newList = [];
    //Get in PopularProductrPro
    QuerySnapshot value = await FirebaseFirestore.instance.collection("dogfood").get();
    if (value.docs != null) {
      //init to null , no will it repeat
      _recommendedProductList = [];
      value.docs.forEach((element) {
        //print(element.data());
        //element.data() QueryDocumentSnapshot<T>
        productModel = ProductModel.fromJson(element.data() as Map<String,dynamic>);
        newList.add(productModel);
      },);
      _recommendedProductList = newList;
      _isLoaded = true;
      update(); //setState
    }
    else {
      print('could not got products rec');
    }
  }
}