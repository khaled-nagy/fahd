import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:elfhad/ConstantVarables.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;

// import '../Data/Models/Locatuion.dart';

class HomeController extends ControllerMVC {
  //to make single instance of class
  factory HomeController() {
    if (_this == null) _this = HomeController._();
    return _this;
  }
  static HomeController _this;

  HomeController._();

  static HomeController get con => _this;
  static final url = ConstantVarable.apiUrl;

  final getAllSectionsStream = StreamController.broadcast();
  void getAllSections() async { 
    await http
        .get(
      "${url}GetAllSections.php?Lang=${ConstantVarable.lang}",
    )
        .then((response) {
      if (response.statusCode == 200) {
        var jsonValu = jsonDecode(response.body);
        print(" Sections Response is ::::::::: " +
            jsonValu['Sections'].toString());
        getAllSectionsStream.sink.add(jsonValu['Sections']);
      }
    }, onError: (error) {
    
      print("CategoryResponse is :::: $error");
    });
  }
}
