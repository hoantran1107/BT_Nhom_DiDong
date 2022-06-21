
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/utils/colors.dart';
import 'dart:io';
import '../../model/product_model.dart';
import 'dialogs.dart';

class PageSVDetail extends StatefulWidget {
  ProdProductsSnapshot? sinhVienSnapshot;
  bool? xem;
  PageSVDetail({Key? key,required this.sinhVienSnapshot,required this.xem}) : super(key: key);

  @override
  State<PageSVDetail> createState() => _PageSVDetailState();
}

class _PageSVDetailState extends State<PageSVDetail> {
  ProdProductsSnapshot? svs;
  bool _imageChange = false;
  XFile? _xImage;
  bool? xem;
  String buttonLabel = "Thêm";
  String title = "Thêm mới Sản phẩm";
  TextEditingController txtId= TextEditingController();
  TextEditingController txtTen= TextEditingController();
  TextEditingController txtMoTa= TextEditingController();
  TextEditingController txtGia= TextEditingController();
  TextEditingController txtXuatXu= TextEditingController();
  TextEditingController txtLoai=TextEditingController();
  TextEditingController txtStart=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryPurple,
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: _imageChange ? Image.file(File(_xImage!.path)):
                    svs?.products!.img !=null ? Image.network(svs!.products!.img as String):null,
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 20,),
                  ElevatedButton(
                      onPressed: xem!=true ? () => _chonAnh(context) :null,
                      child: Icon(Icons.image))
                ],
              ),
              TextField(controller: txtId,
              decoration: InputDecoration(
                label: Text("ID")
              ),),
              Divider(height: 2,),
              TextField(controller: txtTen,
                decoration: InputDecoration(
                  label: Text("Tên")
              ),),
              Divider(height: 2,),
              TextField(controller: txtGia,
                decoration: InputDecoration(
                  label: Text("Gía")
              ),),
              Divider(height: 2,),
              TextField(controller: txtMoTa,
                decoration: InputDecoration(
                  label: Text("Ghi chú")
              ),keyboardType: TextInputType.number,
              ),
              Divider(height: 2,),
              TextField(controller: txtXuatXu,
                decoration: InputDecoration(
                  label: Text("Sao")
              ),
              ),
              Divider(height: 2,),
              TextField(
                controller: txtLoai,
                decoration: InputDecoration(
                    label: Text("Loại")
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () async{
                        if(xem == true){
                          Navigator.pop(context);
                        }
                        else {
                          _capNhat(context);
                        }
                      }, child: Text(buttonLabel)),
                  SizedBox(width: 10,),
                  xem == true ?
                      SizedBox(width: 1,):
                      ElevatedButton(
                          onPressed: () {
                             Navigator.pop(context);
                          },
                          child: Text("Đóng")),
                  SizedBox(width: 10,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _chonAnh(BuildContext context) async{
    _xImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(_xImage !=null){
      setState(() {
        _imageChange=true;
      });
    }
  }
  _capNhat(BuildContext context) async{
    showSnackBar(context, "Đang cập nhật", 300);
    ProductModel sv = ProductModel(
        id: int.parse(txtId.text),
        name: txtTen.text,
        description: txtMoTa.text,
        price:int.parse(txtGia.text),
        stars:int.parse(txtStart.text),
        img: "",
        location: txtXuatXu.text,
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
        typeId: int.parse(txtLoai.text));
    if(_imageChange){ //Có sự thay đổi ảnh
      FirebaseStorage _storage = FirebaseStorage.instance;
      Reference reference = _storage.ref().child("dogfood").child("anh_${sv.id}.jpg");

      UploadTask uploadTask = await _uploadTask(reference,_xImage!);
      uploadTask.whenComplete(() async{
        sv.img = await reference.getDownloadURL();
        if(svs !=null){
          _capNhatSV(svs!,sv);
        }
        else {
          _themSV(sv);
        }
      },).onError((error, stackTrace) {
        return Future.error("Lỗi xảy ra");
      });
    }
    else //nếu không có sự thay đổi anh
      if(svs!=null){
        sv.img = svs!.products!.img;
        _capNhatSV(svs!, sv);
      }
      else {
        _themSV(sv);
      }
  }
  _capNhatSV(ProdProductsSnapshot snapshot,ProductModel sinhVien){
    svs!.updateProduct(sinhVien).whenComplete(() => showSnackBar(context, "Cập nhật dữ liệu thành công", 3)
    ).onError((error, stackTrace) => showSnackBar(context, "Cập nhật dữ liệu không thành công", 3));
  }
  _themSV(ProductModel sv){
    ProdProductsSnapshot.addProduct(sv).whenComplete(() =>
        showSnackBar(context, "Thêm sản phẩm thành công", 3)).
    onError((error, stackTrace) {
      showSnackBar(context, error.toString(), 3);
      return Future.error("Lỗi khi thêm");
    },);
  }
  Future<UploadTask> _uploadTask(Reference reference,XFile xImage) async{
    final metadata = SettableMetadata(
    contentType: 'image/jpeg',
    customMetadata: {'picked-file-path':xImage.path});
    UploadTask uploadTask;
    if(kIsWeb){
      uploadTask = reference.putData(await xImage.readAsBytes(),metadata);
    }
    else
      uploadTask = reference.putFile(File(xImage.path),metadata);
    return Future.value(uploadTask);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    svs = widget.sinhVienSnapshot;
    xem = widget.xem;
    if(svs!=null){
      txtId.text = svs!.products!.id.toString();
      txtTen.text = svs!.products!.name ?? "";
      txtGia.text = svs!.products!.price.toString();
      txtMoTa.text = svs!.products!.description ?? "";
      txtXuatXu.text = svs!.products!.location ?? "";
      txtStart.text = svs!.products!.stars.toString();
      txtLoai.text = svs!.products!.typeId.toString();
    }
    if(xem == true){
      title = "Thông tin sản phẩm";
      buttonLabel = "Đóng";
    }
    else{
      if(svs!=null) {
        title = "Cập nhật thông tin";
        buttonLabel = "Cập nhật";
      }
    }
  }

}
