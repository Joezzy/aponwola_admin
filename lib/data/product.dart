// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String? id;
  String? name;
  String? category;
  double? price;
  String? description;
  String? image;

  Product({
    this.id,
    this.name,
    this.category,
    this.price,
    this.description,
    this.image,
  });

  toJson(){
    return {"price": price, "name": name, "description": description, "category": category,"image":image};
  }
  factory Product.fromSnapShot(QueryDocumentSnapshot<Object?> documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return  Product(
      id: documentSnapshot.id,
      name: data["name"],
      category: data["category"],
      price: data["price"]==null?0.0:double.parse( data["price"].toString()),
      description: data["description"],
      image: data["image"],
    );
  }



}

// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);
