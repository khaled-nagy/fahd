import 'package:easy_localization/easy_localization.dart';

import 'package:elfhad/ConstantVarables.dart';
import 'package:elfhad/src/controllers/UserLocalStorage.dart';
import 'package:elfhad/src/data/services/UserServicess.dart';
import 'package:elfhad/src/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends ControllerMVC {
  //to make single instance of class
  factory UserController() {
    if (_this == null) _this = UserController._();
    return _this;
  }
  static UserController _this;

  UserController._();

  static UserController get con => _this;

  bool apiCall = false;
  String errorMsg = "";
  bool error = true;
  UserService userService = UserService();

  Future<bool> signInWithEmailAndPassword(
      BuildContext context, String email, String pass) async {
    final form = ConstantVarable.loginformKey.currentState;
    ConstantVarable.loginAutoValid = true;
    if (form.validate()) {
      form.save();

      await userService.signInWithEmailAndPassword(email, pass).then((user) {
        if (user.success == 1) {
          UserLocalStorage().saveClient(user).then((saved) {
            ConstantVarable.userName = user.name;

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (Route<dynamic> route) => false);
          });

          return true;
        } else {
          setState(() {
            errorMsg = user.message;
          });
          return false;
        }
      });
    }
    refresh();

    return false;
  }

  Future<bool> regNewUser(BuildContext context, String name, String pass,
      String email, String address, String mobile) async {
    final form = ConstantVarable.regformKey.currentState;
    ConstantVarable.regAutoValid = true;
    if (form.validate()) {
      form.save();

      await userService
          .regNewUser(name, pass, email, address, mobile)
          .then((user) {
        if (user.success == 1) {
          UserLocalStorage().saveClient(user).then((saved) {
            if (saved == true) {
              ConstantVarable.userName = user.name;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (Route<dynamic> route) => false);
            }
          });

          print("true");
          return true;
        } else {
          setState(() {
            errorMsg = user.message;
          });
          print("false");
          return false;
        }
      });
    }
    refresh();

    return false;
  }

  Future<bool> logOut() async {
    clearTextFields();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    return true;
  }

  void clearTextFields() {
    ConstantVarable.userNameController.text = "";
    ConstantVarable.emailController.text = "";
    ConstantVarable.passwordController.text = "";
    ConstantVarable.confirmPasswordController.text = "";
    ConstantVarable.phoneController.text = "";
    ConstantVarable.userName = "_user_name".tr();
    ConstantVarable.userId = "";
    ConstantVarable.cityId = "";
    ConstantVarable.subSectionId = "";
    setState(() {
      errorMsg = "";
    });
  }

  Widget showErrorMsg() {
    return Text(
      errorMsg ?? "",
      style: new TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  String validateUserName(String val) {
    if (val.trim().isEmpty) {
      return "من فضلك ادخل اسم المستحدم";
    } else
      return null;
  }

  String validatePhone(String val) {
    if (val.trim().isEmpty) {
      return "من فضلك ادخل رقم الهاتف";
    } else
      return null;
  }

  String validateEmail(String val) {
    if (val.isEmpty)
      return "ادخل البريد الالكترونى";
    else {
      final _emailRegExpString = r'[a-zA-Z0-9\+\.\_\%\-\+]{1,256}\@[a-zA-Z0-9]'
          r'[a-zA-Z0-9\-]{0,64}(\.[a-zA-Z0-9][a-zA-Z0-9\-]{0,25})+';
      if (!RegExp(_emailRegExpString, caseSensitive: false).hasMatch(val)) {
        return "البريد الاكترونى غير صالح";
      } else
        return null;
    }
  }

  String validatePassword(String val) {
    if (val.trim().isEmpty)
      return "من فضلك ادخل الرقم السرى";
    else if (val.length < 8) {
      return "الرقم السرى اقل من 8";
    } else
      return null;
  }

  String validateStudentCode(String val) {
    if (val.trim().isEmpty)
      return "من فضلك ادخل كود الطالب";
    else
      return null;
  }

  String validateConfirmPassword(String val) {
    if (val.trim().isEmpty)
      return "من فضلك ادخل الرقم السرى";
    else if (val != ConstantVarable.passwordController.text) {
      return "الرقم السرى غير مطابق";
    } else
      return null;
  }

  String validateAnyFeild(BuildContext context , String val) {
    if (val.trim().isEmpty) {
      if (EasyLocalization.of(context).locale == Locale('ar')) {
        return "من فضلك لا تترك الحقل فارغا";
      } else {
        return "Please do not leave the field blank";
      }
    } else
      return null;
  }
}
