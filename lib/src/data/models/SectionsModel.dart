// To parse this JSON data, do
//
//     final sectionsModel = sectionsModelFromJson(jsonString);

import 'dart:convert';

SectionsModel sectionsModelFromJson(String str) => SectionsModel.fromJson(json.decode(str));

String sectionsModelToJson(SectionsModel data) => json.encode(data.toJson());

class SectionsModel {
    SectionsModel({
        this.id,
        this.name,
        this.image,
    });

    String id;
    String name;
    String image;

    factory SectionsModel.fromJson(Map<String, dynamic> json) => SectionsModel(
        id: json["id"],
        name: json["Name"],
        image: json["Image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
        "Image": image,
    };
}