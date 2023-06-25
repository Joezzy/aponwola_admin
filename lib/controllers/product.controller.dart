
import 'dart:convert';
import 'dart:typed_data';

import 'package:aponwola_admin/common/constant.dart';
import 'package:aponwola_admin/data/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  CollectionReference products = FirebaseFirestore.instance.collection('products');
  final FirebaseStorage _storage=FirebaseStorage.instance;

  var productList=<Product>[].obs;


Future getProducts()async {
  try{
    final prod=await products.
    orderBy('name', descending: true).get();
    productList.value= prod.docs.map((doc) => Product.fromSnapShot(doc)).toList();
  }catch(e){
    print(e);
  }
}
Future deleteProduct(id)async {

  try{
    return products
        .doc(id)
        .delete()
        .then((value) {
          print("Product Deleted");
          getProducts();
            })
        .catchError((error) => print("Failed to delete user: $error"));

  }catch(e){
    print(e);
  }
}
  final key=GlobalKey<FormState>().obs;

  var nameController=TextEditingController().obs;
  var descriptionController=TextEditingController().obs;
  var priceController=TextEditingController().obs;
  var category="".obs;
  var isLoading=false.obs;


Future addProducts(context,file)async {

  String img="";
  if(file!=null){
    img=await uploadImageToStorage("products/image", file);
  }

    var res=await products
        .add({
      'name': nameController.value.text,
      'category': category.value,
      'description': descriptionController.value.text,
      'price': priceController.value.text ,
      'image': img
    }).then((value) {
      print("Product Added");
      getProducts();
      Navigator.pop(context);
    }).catchError((error) {
      print("Failed to add user: $error");
    });





 }
Future updateProducts(context,id)async {

    var res=await products.doc(id)
        .update({
      'name': nameController.value.text, // John Doe
      'category': category.value, // Stokes and Sons
      'description': descriptionController.value.text, // Stokes and Sons
      'price': priceController.value.text // 42
    }).then((value) {
      print("Product updated");
      getProducts();
      Navigator.pop(context);
    }).catchError((error) {
      print("Failed to add user: $error");
    });





 }

  Future<String> uploadImageToStorage(String childName, Uint8List file)async{
    Reference ref=_storage.ref().child(childName);
    UploadTask uploadTask=ref.putData(file);
    TaskSnapshot snapshot=await uploadTask;
    String downloadUrl= await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

}