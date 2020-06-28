// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.success,
        this.id,
        this.email,
        this.name,
        this.address,
        this.mobile,
        this.message
    });

    int success;
    String id;
    String email;
    String name;
    String address;
    String mobile;
    String message;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json["success"],
        id: json["id"],
        email: json["Email"],
        name: json["Name"],
        address: json["Address"],
        mobile: json["Mobile"],
        message: json["message"]
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "id": id,
        "Email": email,
        "Name": name,
        "Address": address,
        "Mobile": mobile,
        "message": message
    };
}
