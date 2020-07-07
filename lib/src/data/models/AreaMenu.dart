// To parse this JSON data, do
//
//     final cityMenu = cityMenuFromJson(jsonString);

import 'dart:convert';

AreaMenu areaMenuFromJson(String str) => AreaMenu.fromJson(json.decode(str));

String areaMenuToJson(AreaMenu data) => json.encode(data.toJson());

class AreaMenu {
  AreaMenu({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory AreaMenu.fromJson(Map<String, dynamic> json) => AreaMenu(
    id: json["id"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Name": name,
  };
}