import 'dart:async';

import 'package:elfhad/ConstantVarables.dart';
import 'package:elfhad/src/controllers/UserController.dart';
import 'package:elfhad/src/screens/login_screen.dart';
import 'package:elfhad/src/widgets/AppBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class NewPasswordScreen extends StatefulWidget {
  String modifyOrNew;
  NewPasswordScreen({this.modifyOrNew});
  createState() => NewPasswordView();
}

class NewPasswordView extends StateMVC<NewPasswordScreen> {
  NewPasswordView() : super(UserController()) {
    _userController = UserController.con;
  }

  UserController _userController;
  bool isLoading = false;

  String titleNew = "الرقم السرى الجديد";
   String titleModify = "تعديل الرقم السرى ";
  final GlobalKey<ScaffoldState> _scaffoldKeyHome =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKeyHome,
        appBar: AppBarWidget().showAppBar(context, "" ,Container() , false),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          child: Image.asset(
                            "assets/imgs/Artboard.png",
                            width: MediaQuery.of(context).size.width / 1.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "يرجى ادخال الرقم السرى الجديد",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 50,
                        ),
                        widget.modifyOrNew=="modify"?  Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.grey[300]),
                              borderRadius: BorderRadius.circular(12)),
                          height: 50,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, right: 16, left: 16),
                                child: Image.asset(
                                  "assets/imgs/ic_lock.png",
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: TextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    controller:
                                        ConstantVarable.oldPassController,
                                    validator: (val) =>
                                        _userController.validatePassword(val),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          right: 4.0, top: 0.0, left: 4),
                                      hintText: "الرقم السرى القديم",
                                      hintStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ):Text(""),
                        Container(height: 25,),
                        Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.grey[300]),
                              borderRadius: BorderRadius.circular(12)),
                          height: 50,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, right: 16, left: 16),
                                child: Image.asset(
                                  "assets/imgs/ic_lock.png",
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: TextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    controller:
                                        ConstantVarable.passwordController,
                                    validator: (val) =>
                                        _userController.validatePassword(val),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          right: 4.0, top: 0.0, left: 4),
                                      hintText: "الرقم السرى الجديد",
                                      hintStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(height: 25,),
                           Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.grey[300]),
                              borderRadius: BorderRadius.circular(12)),
                          height: 50,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, right: 16, left: 16),
                                child: Image.asset(
                                  "assets/imgs/ic_lock.png",
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: TextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    controller:
                                        ConstantVarable.confirmPasswordController,
                                    validator: (val) =>
                                        _userController.validateConfirmPassword(val),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          right: 4.0, top: 0.0, left: 4),
                                      hintText: "تاكيد الرقم السرى الجديد",
                                      hintStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                        ),
                        InkWell(
                                child: Container(
                                  height: 45.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: Material(
                                    color: const Color(0xff833B8C),
                                    elevation: 0.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 0.0, bottom: 0.0),
                                        child: Text(
                                          "تاكيد",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontFamily: 'JF Flat'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                 Navigator.pushReplacement(context, MaterialPageRoute(
                                   builder: (context)=>LoginScreen()
                                 ));
                                },
                              ),
                        Container(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> _dialogResetPassword(BuildContext context) async {
    // check if 0 skill , 1 history , 2 education
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          content: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Image.asset(
                    "assets/imgs/res_photo.PNG",
                    width: 100,
                    height: 100,
                  ),
                  Text(
                      "تم إعادة تعيين كلمة المرور الخاصة بك",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[800], fontSize: 15)),
                  Text(
                  "تسلم",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: InkWell(
                      child: new Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: new Material(
                            color: Color(0xffE5345D),
                            elevation: 0.0,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                                side: BorderSide(
                                    color: Colors.white, width: 2.0)),
                            child: new Center(
                                child: new Padding(
                                    padding: new EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: new Text(
                                      "تم",
                                      style: new TextStyle(
                                          color: Colors.white, fontSize: 15.0),
                                    )))),
                      ),
                      onTap: () {
                        Navigator.pop(context);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoginScreen()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[],
            ),
          ],
        );
      },
    );
  }
}
