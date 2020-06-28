import 'dart:async';
import 'dart:convert';

import 'package:elfhad/ConstantVarables.dart';
import 'package:elfhad/src/data/models/AdvertiseModel.dart';
import 'package:elfhad/src/screens/home_screen.dart';
import 'package:elfhad/src/screens/user_adds_screen.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;

// import '../Data/Models/Locatuion.dart';

class InformationController extends ControllerMVC {
  //to make single instance of class
  factory InformationController() {
    if (_this == null) _this = InformationController._();
    return _this;
  }
  static InformationController _this;

  InformationController._();

  static InformationController get con => _this;
  static final url = ConstantVarable.apiUrl;

  final getAboutAppStream = StreamController.broadcast();
  void getAboutApp() async {
    await http
        .get(
      "${url}GetContent.php?Lang=${ConstantVarable.lang}&id=3",
    )
        .then((response) {
      if (response.statusCode == 200) {
        var jsonValu = jsonDecode(response.body);
        print(" about app Response is ::::::::: " + jsonValu.toString());
        getAboutAppStream.sink.add(jsonValu);
      }
    }, onError: (error) {
      getAboutAppStream.close();
      print("about app Response is :::: $error");
    });
  }

  final getAboutUsStream = StreamController.broadcast();
  void getAboutUs() async {
    await http
        .get(
      "${url}GetContent.php?Lang=${ConstantVarable.lang}&id=4",
    )
        .then((response) {
      if (response.statusCode == 200) {
        var jsonValu = jsonDecode(response.body);
        print(" about us Response is ::::::::: " + jsonValu.toString());
        getAboutUsStream.sink.add(jsonValu);
      }
    }, onError: (error) {
      getAboutUsStream.close();
      print("about us Response is :::: $error");
    });
  }

  Future<AdvertiseModel> sendMessage(
    String name,
    String title,
    String phone,
    String address,
    String message,
  ) async {
    
    return await http
        .post(
            "${url}CallUs.php?Name=$name&Title=$title&Mobile=$phone&Address=$address&Message=$message")
        .then((response) {
      if (response.statusCode == 200) {
        print(response.statusCode.toString());
        var jsonValue = jsonDecode(response.body);

        return AdvertiseModel.fromJson(jsonValue);
      } else {
        return AdvertiseModel();
      }
    });
  }

  Future<bool> sendMessageLogic(
    BuildContext context,
    String name,
    String title,
    String phone,
    String address,
    String message,
  ) async {

        final form = ConstantVarable.sendMessageFormKey.currentState;
    ConstantVarable.sendMessageAutoValid = true;
    if(form.validate()){
      form.save();
          return sendMessage(name, title, phone, address, message)
        .then((advertiseModel) {
      if (advertiseModel.success == 1) {
        form.reset();
        print("message is :: " + advertiseModel.message.toString());
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        return true;
      } else {
        print("message is :: " + advertiseModel.message.toString());

        return false;
      }
    });

    }
      return false;

  }
}
