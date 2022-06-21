import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  ProductModel(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.stars,
        this.img,
        this.location,
        this.createdAt,
        this.updatedAt,
        this.typeId});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'price': this.price,
      'stars': this.stars,
      'img': this.img,
      'location': this.location,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'typeId': this.typeId,
    };
  }

}
class ProdProductsSnapshot{
  ProductModel? products;
  DocumentReference? docRef;
  ProdProductsSnapshot({
    required this.products,
    required this.docRef,
  });

  factory ProdProductsSnapshot.formSnapshot(DocumentSnapshot docSnap){
    return
      ProdProductsSnapshot(
          products: ProductModel.fromJson(docSnap.data() as Map<String, dynamic>),
          docRef: docSnap.reference);
  }

  Future<void> updateProduct(ProductModel products) async{
    await docRef!.update(products.toJson());

  }

  Future<void> delete() async{
    await docRef!.delete();
  }

  static Future<DocumentReference> addProduct(ProductModel sv){
    return FirebaseFirestore.instance.collection("dogfood").add(sv.toJson());
  }

  static Stream<List<ProdProductsSnapshot>> getAllProduct(){
    Stream<QuerySnapshot> qs = FirebaseFirestore.instance.collection("dogfood").orderBy("id").snapshots();
    Stream<List<DocumentSnapshot>> listDocSnap = qs.map((querySnapshot) => querySnapshot.docs);
    return listDocSnap.map(
            (listds) => listds.map((docSnap) => ProdProductsSnapshot.formSnapshot(docSnap)).toList());
  }

  static Stream<List<ProdProductsSnapshot>> getAllDog(){
    Stream<QuerySnapshot> qs = FirebaseFirestore.instance.collection("products").snapshots();
    Stream<List<DocumentSnapshot>> listDocSnap = qs.map((querySnapshot) => querySnapshot.docs);
    return listDocSnap.map(
            (listds) => listds.map((docSnap) => ProdProductsSnapshot.formSnapshot(docSnap)).toList());
  }
}