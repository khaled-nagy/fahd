import 'dart:async';

import 'package:elfhad/ConstantVarables.dart';
import 'package:elfhad/src/controllers/UserController.dart';
import 'package:elfhad/src/widgets/AppBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:elfhad/src/widgets/TextFormFieldW.dart';
import 'package:easy_localization/easy_localization.dart';


class ForgotPasswordScreen extends StatefulWidget {
  createState() => ForgotPasswordView();
}

class ForgotPasswordView extends StateMVC<ForgotPasswordScreen> {
  ForgotPasswordView() : super(UserController()) {
    _userController = UserController.con;
  }

  UserController _userController;
   bool isLoading = false;

  String title = "_forgot_pass_title".tr();
  final GlobalKey<ScaffoldState> _scaffoldKeyHome =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKeyHome,
       
        appBar: AppBarWidget().showAppBar(context, "" , Container() , false),
        body:  SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Column(
                children: <Widget>[
                

                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: <Widget>[
                         Padding(
                  padding: const EdgeInsets.only(top: 20 ,),
                  child: Image.asset(
                    "assets/imgs/logo.png",
                    width: MediaQuery.of(context).size.width / 1.5,
                   
                  ),
                ),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Text(
                              "_forgot_message".tr(),
                              style:
                                    TextStyle(fontSize: 12, color: Theme.of(context).accentColor,fontWeight: FontWeight.bold),
                            ),
                                 ),
                               Container(
                                height: 50,
                              ),
                                  TextFormFieldW(
                          textInputType: TextInputType.emailAddress,
                          controller: ConstantVarable.emailController,
                          validator: (val) =>
                                        _userController.validateEmail(val),
                                      image: "assets/imgs/user.png",
                                      hintText: "_email".tr(),
                                      obSecureText: false,
                        ),
                              Container(
                                height: 50,
                              ),

                   
                    
                   InkWell(
                                child: Container(
                                  height: 45.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: Material(
                                    color: Theme.of(context).accentColor,
                                    elevation: 0.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 0.0, bottom: 0.0),
                                        child: Text(
                                          "_reset".tr(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                             ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                //  Navigator.push(context, MaterialPageRoute(
                                //    builder: (context)=> NewPasswordScreen()
                                //  ));
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
       
        );
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
              height: MediaQuery.of(context).size.height/1.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Image.asset("assets/imgs/res_photo.PNG", width: 100,height: 100,),
                  Text(
                    "_reset_message".tr(),
                    textAlign: TextAlign.center,style: TextStyle(color: Colors.grey[800] ,fontSize: 15)
                  ),
                   Text(
                   "تسلم",
                    textAlign: TextAlign.center,style: TextStyle(color: Colors.grey[500] ,fontSize: 12),
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
                                side:
                                    BorderSide(color: Colors.white, width: 2.0)),
                            child: new Center(
                                child: new Padding(
                                    padding: new EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: new Text(
                                      "_done".tr(),
                                      style: new TextStyle(
                                          color: Colors.white, fontSize: 15.0),
                                    )))),
                      ),
                      onTap: () {
                        // Navigator.pop(context);

                        // Navigator.pushReplacement(context, MaterialPageRoute(
                        //   builder: (BuildContext context)=> LoginScreen()
                        // ));
                      


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
              children: <Widget>[
              
             
              ],
            ),
          ],
        );
      },
    );
  }
}
