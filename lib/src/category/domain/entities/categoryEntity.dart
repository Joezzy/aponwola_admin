import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryEntity {
  final String? id;
  final String? name;
  final String? description;
  final String? type;
  final dynamic image;

  CategoryEntity({
    this.id,
    this.name,
    this.description,
    this.type,
    this.image,
  });

  factory CategoryEntity.fromRawJson(String str) => CategoryEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryEntity.fromJson(Map<String, dynamic> json) => CategoryEntity(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    type: json["type"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "type": type,
    "image": image,
  };

  factory CategoryEntity.fromSnapShot(QueryDocumentSnapshot<Object?> documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return  CategoryEntity(
      id: documentSnapshot.id,
      name: data["name"],
      description: data["description"],
      image: data["image"],
      type: data["type"],
    );
  }

}
