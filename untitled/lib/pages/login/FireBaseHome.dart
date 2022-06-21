import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled/pages/login/page_firebase_detail.dart';

import '../../model/product_model.dart';
import '../../utils/colors.dart';
import '../../utils/dimentions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import 'dialogs.dart';
import 'login_page.dart';

class HomeFireBase extends StatefulWidget {
  const HomeFireBase({Key? key}) : super(key: key);

  @override
  State<HomeFireBase> createState() => _HomeFireBaseState();
}

class _HomeFireBaseState extends State<HomeFireBase> {
  BuildContext? dialogContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Fire Base Home"),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PageSVDetail(xem: false, sinhVienSnapshot: null,),));
          }, icon:Icon(Icons.add_circle_outline))
        ],
      ),
      drawer: Container(
        width: 200,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("My Firebase App"),
            SizedBox(
              height: 50,
            ),
            TextButton(onPressed: () {
              Get.snackbar("Nhắc nhở",
                  "Signing out....",
                  backgroundColor: AppColors.mainColor,

                  colorText: Colors.white,
                  duration: Duration(seconds: 300));
                FirebaseAuth.instance.signOut().whenComplete(() {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyLogin(),), (route) => false);
                  Get.snackbar("Nhắc nhở",
                      "Please sign in!",
                      backgroundColor: AppColors.mainColor,

                      colorText: Colors.white,
                      duration: Duration(seconds: 5));
                }).catchError((error) {
                  Get.snackbar("Nhắc nhở",
                      "Sign out not successfully",
                      backgroundColor: AppColors.mainColor,

                      colorText: Colors.white,
                      duration: Duration(seconds: 3));
                });
            }, child: Row(
              children: [
                Icon(Icons.assignment_return_outlined),
                SizedBox(width: 5,),
                Text("Sign out")
              ],
            ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<ProdProductsSnapshot>>(
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
            else
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator());
              }
              else {
                var product = snapshot.data!;
                return snapshot.hasData ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: product.length,
                  shrinkWrap: true,
                  // itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    dialogContext = context;
                    print(product.length);
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            icon: Icons.details,
                            foregroundColor: Colors.green,
                            onPressed: (context) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      PageSVDetail(
                                        xem: true,
                                        sinhVienSnapshot: snapshot.data![index],),));
                            }
                            ,),
                          SlidableAction(
                            icon: Icons.edit,
                            foregroundColor: Colors.blue,
                            onPressed: (context) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PageSVDetail(xem: false, sinhVienSnapshot: snapshot.data![index],),));
                            },),
                          SlidableAction(
                            icon: Icons.delete,
                            foregroundColor: Colors.red,
                            onPressed: (context) {
                              _xoa(dialogContext!,snapshot.data![index]);
                            },),
                        ],
                      ),
                      child: Container(
                        margin: EdgeInsets.only(left: Dimentions.width20,right: Dimentions.width20 , bottom:Dimentions.height10),
                        child: Row(
                          children: [
                            //image section
                            Container(
                              width:Dimentions.listViewImgSize,
                              height: Dimentions.listViewImgSize,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimentions.radius20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        //recommendedProduct.recommendedProductList[index].img!
                                          product[index].products!.img ?? ""
                                      )
                                  )
                              ),
                            ),
                            //text container
                            Expanded(
                              child: Container(
                                height: Dimentions.listViewImgSize,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(Dimentions.radius20),
                                        bottomRight: Radius.circular(Dimentions.radius20)
                                    ),
                                    color: Colors.white10
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: Dimentions.width10,right: Dimentions.width10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(
                                          text: product[index].products!.name ?? ""
                                        //recommendedProduct.recommendedProductList[index].name!
                                      )
                                      ,
                                      SizedBox(height: Dimentions.height10,),
                                      BigText(
                                        text:product[index].products!.description ?? ""
                                        //recommendedProduct.recommendedProductList[index].description!
                                        ,size: 12,color: AppColors.mainBlackColor,),
                                      SizedBox(height: Dimentions.height10,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndText(
                                              icon: Icons.circle_sharp,
                                              text: 'Normal',
                                              iconColor: AppColors.iconColor1),
                                          IconAndText(
                                              icon: Icons.location_on,
                                              text: '1.7 km',
                                              iconColor: AppColors.mainColor),
                                          IconAndText(
                                              icon: Icons.access_time_rounded,
                                              text: '32 min',
                                              iconColor: AppColors.iconColor2),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ) : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
              }
          },
          stream: ProdProductsSnapshot.getAllProduct(),
        ),
      ),
    );

  }
  void _xoa(BuildContext context,ProdProductsSnapshot svs) async{
    String? confirm;
    confirm = await showConfirmDialog(context, "Bạn có muốn xóa sv: ${svs.products!.name} ?");
    if(confirm == "ok"){
      FirebaseStorage _storeage = FirebaseStorage.instance;
      Reference reference = _storeage.ref().child("dogfood").child("${svs.products!.img}");
      reference.delete().whenComplete(() => showSnackBar(context,"Xóa ảnh không thành công",3)
      ).onError((error, stackTrace) {
        showSnackBar(context, "Xoá ảnh không thành công", 3);
        return Future.error(error.toString());
      }
      );
      svs.delete().whenComplete(() => showSnackBar(context, "Xóa dữ liệu thành công", 3))
      .onError((error, stackTrace) {
        showSnackBar(context, "Xóa dữ liệu không thành công", 3);
        return Future.error("Xóa dữ liệu không thành công");
      });
    }
  }
  }
