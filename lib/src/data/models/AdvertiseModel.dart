// To parse this JSON data, do
//
//     final advertiseModel = advertiseModelFromJson(jsonString);

import 'dart:convert';

AdvertiseModel advertiseModelFromJson(String str) => AdvertiseModel.fromJson(json.decode(str));

String advertiseModelToJson(AdvertiseModel data) => json.encode(data.toJson());

class AdvertiseModel {
    AdvertiseModel({
        this.success,
        this.message,
    });

    int success;
    String message;

    factory AdvertiseModel.fromJson(Map<String, dynamic> json) => AdvertiseModel(
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
    };
}