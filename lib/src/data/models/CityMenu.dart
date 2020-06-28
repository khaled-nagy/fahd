// To parse this JSON data, do
//
//     final cityMenu = cityMenuFromJson(jsonString);

import 'dart:convert';

CityMenu cityMenuFromJson(String str) => CityMenu.fromJson(json.decode(str));

String cityMenuToJson(CityMenu data) => json.encode(data.toJson());

class CityMenu {
    CityMenu({
        this.id,
        this.name,
    });

    String id;
    String name;

    factory CityMenu.fromJson(Map<String, dynamic> json) => CityMenu(
        id: json["id"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
    };
}