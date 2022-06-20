import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProdProducts {
  String? productImage;
  String? name;
  String? brand;
  double? price;
  double? totalPrice;
  String? desc;
  String? moreDesc;
  String? foodType;
  String? lifeStage;
  String? flavor;
  String? weight;
  String? ingredients;
  String? directions;
  String? size;
  String? productID;
  String? pet;
  String? category;
  String? subCategory;
  String? service;
  String? tag;
  int? quantity;

  ProdProducts({
    this.productImage,
    this.name,
    this.brand,
    this.price,
    this.totalPrice,
    this.desc,
    this.moreDesc,
    this.foodType,
    this.lifeStage,
    this.flavor,
    this.weight,
    this.ingredients,
    this.directions,
    this.size,
    this.productID,
    this.pet,
    this.category,
    this.subCategory,
    this.service,
    this.tag,
    this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'productImage': this.productImage,
      'name': this.name,
      'brand': this.brand,
      'price': this.price,
      'totalPrice': this.totalPrice,
      'desc': this.desc,
      'moreDesc': this.moreDesc,
      'foodType': this.foodType,
      'lifeStage': this.lifeStage,
      'flavor': this.flavor,
      'weight': this.weight,
      'ingredients': this.ingredients,
      'directions': this.directions,
      'size': this.size,
      'productID': this.productID,
      'pet': this.pet,
      'category': this.category,
      'subCategory': this.subCategory,
      'service': this.service,
      'tag': this.tag,
      'quantity': this.quantity,
    };
  }

  factory ProdProducts.fromJson(Map<String, dynamic> map) {
    return ProdProducts(
      productImage: map['productImage'] as String?,
      name: map['name'] as String?,
      brand: map['brand'] as String?,
      price: map['price'] as double?,
      totalPrice: map['totalPrice'] as double?,
      desc: map['desc'] as String?,
      moreDesc: map['moreDesc'] as String?,
      foodType: map['foodType'] as String?,
      lifeStage: map['lifeStage'] as String?,
      flavor: map['flavor'] as String?,
      weight: map['weight'] as String?,
      ingredients: map['ingredients'] as String?,
      directions: map['directions'] as String?,
      size: map['size'] as String?,
      productID: map['productID'] as String?,
      pet: map['pet'] as String?,
      category: map['category'] as String?,
      subCategory: map['subCategory'] as String?,
      service: map['service'] as String?,
      tag: map['tag'] as String?,
      quantity: map['quantity'] as int?,
    );
  }
}
class ProdProductsSnapshot{
  ProdProducts? products;
  DocumentReference? docRef;
  ProdProductsSnapshot({
    required this.products,
    required this.docRef,
  });

  factory ProdProductsSnapshot.formSnapshot(DocumentSnapshot docSnap){
    return
      ProdProductsSnapshot(
          products: ProdProducts.fromJson(docSnap.data() as Map<String, dynamic>),
          docRef: docSnap.reference);
  }

  Future<void> updateProduct(ProdProducts products) async{
    await docRef!.update(products.toJson());

  }

  Future<void> delete() async{
    await docRef!.delete();
  }

  static Future<DocumentReference> addProduct(ProdProducts sv){
    return FirebaseFirestore.instance.collection("food").add(sv.toJson());
  }

  static Stream<List<ProdProductsSnapshot>> getAllProduct(){
    Stream<QuerySnapshot> qs = FirebaseFirestore.instance.collection("food").snapshots();
    Stream<List<DocumentSnapshot>> listDocSnap = qs.map((querySnapshot) => querySnapshot.docs);
    return listDocSnap.map(
            (listds) => listds.map((docSnap) => ProdProductsSnapshot.formSnapshot(docSnap)).toList());
  }
}