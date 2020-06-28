// To parse this JSON data, do
//
//     final subSectionsModel = subSectionsModelFromJson(jsonString);

import 'dart:convert';

SubSectionsModel subSectionsModelFromJson(String str) => SubSectionsModel.fromJson(json.decode(str));

String subSectionsModelToJson(SubSectionsModel data) => json.encode(data.toJson());

class SubSectionsModel {
    SubSectionsModel({
        this.id,
        this.name,
        this.image,
    });

    String id;
    String name;
    String image;

    factory SubSectionsModel.fromJson(Map<String, dynamic> json) => SubSectionsModel(
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