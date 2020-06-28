
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:elfhad/src/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SharedWidget {
  static loading(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  static void showSnackBar(GlobalKey<ScaffoldState> key, message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 4),
    );
    key.currentState.showSnackBar(snackBar);
  }

  static Future<void> alertDialog(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.height / 9,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        EasyLocalization.of(context).locale == Locale('en')
                            ? "Error"
                            : "خطاء",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 23,
                            color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
                Text(
                  text,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 25,
                      color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            InkWell(
              child: Container(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width / 4,
                child: Material(
                  color: Theme.of(context).accentColor,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                      child: Text(
                        EasyLocalization.of(context).locale == Locale('en')
                            ? "ok"
                            : "حسنا",
                        style: TextStyle(
                            color: Colors.grey[50],
                            fontSize: MediaQuery.of(context).size.width / 23),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  static Future<void> customAlertDialog(
      BuildContext context, String message, Function function) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setMyState) =>
              AlertDialog(
            content: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height / 11,
                
              ),
                          child: Container(
               height: MediaQuery.of(context).size.height/5,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.error,
                            color: Theme.of(context).accentColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width/2.1,
                                                          child: Column(
                                children: <Widget>[
                                  Text(
                                    message,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width / 25,
                                        color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              InkWell(
                child: Container(
                  height: MediaQuery.of(context).size.height / 20,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Material(
                    color: Theme.of(context).accentColor,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                        child: Text(
                          EasyLocalization.of(context).locale == Locale('en')
                              ? "cancel"
                              : "الغاء",
                          style: TextStyle(
                              color: Colors.grey[50],
                              fontSize: MediaQuery.of(context).size.width / 23),
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              InkWell(
                child: Container(
                  height: MediaQuery.of(context).size.height / 20,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Material(
                    color: Theme.of(context).accentColor,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                        child: Text(
                          EasyLocalization.of(context).locale == Locale('en')
                              ? "ok"
                              : "حسنا",
                          style: TextStyle(
                              color: Colors.grey[50],
                              fontSize: MediaQuery.of(context).size.width / 23),
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () async {
                  setMyState(() {});

                  Navigator.pop(context);

                  await function();
                },
              )
            ],
          ),
        );
      },
    );
  }

  static Future<void> wonderAlertDialog(
      BuildContext context, Function sendOrder) {
    var progressDialog = ProgressDialog(context, isDismissible: false);

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setMyState) =>
              AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height / 11,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.error,
                          color: Theme.of(context).accentColor,
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                EasyLocalization.of(context).locale == Locale('en')
                                    ? "login "
                                    : " سجل دخول ",
                                style: Theme.of(context).textTheme.title
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              InkWell(
                child: Container(
                  height: MediaQuery.of(context).size.height / 20,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Material(
                    color: Theme.of(context).accentColor,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                        child: Text(
                          EasyLocalization.of(context).locale == Locale('en')
                              ? "cancel"
                              : "الغاء",
                          style: TextStyle(
                              color: Colors.grey[50],
                              fontSize: MediaQuery.of(context).size.width / 23),
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              InkWell(
                child: Container(
                  height: MediaQuery.of(context).size.height / 20,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Material(
                    color: Theme.of(context).accentColor,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                        child: Text(
                          EasyLocalization.of(context).locale == Locale('en')
                              ? "ok"
                              : "حسنا",
                          style: TextStyle(
                              color: Colors.grey[50],
                              fontSize: MediaQuery.of(context).size.width / 23),
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () async {
                  setMyState(() {});

                  Navigator.pop(context);
                  await progressDialog.show();

                  await sendOrder();
                  progressDialog.hide();
                },
              )
            ],
          ),
        );
      },
    );
  }

  static Future<void> successAlertDialog(
      BuildContext context, String text, Function medthod) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.height / 9,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/imgs/checkmark_1.png",
                      width: 30,
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        EasyLocalization.of(context).locale == Locale('en')
                            ? "Correct"
                            : "صح",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 23,
                            color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
                Text(
                  text,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 25,
                      color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            InkWell(
              child: Container(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width / 4,
                child: Material(
                  color: Theme.of(context).accentColor,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                      child: Text(
                        EasyLocalization.of(context).locale == Locale('en')
                            ? "ok"
                            : "حسنا",
                        style: TextStyle(
                            color: Colors.grey[50],
                            fontSize: MediaQuery.of(context).size.width / 23),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                medthod();
              },
            )
          ],
        );
      },
    );
  }

  static Future<void> logOutAlertDialog(
      BuildContext context, String text, Function sendOrder) {
   

    return showDialog(
      context: context,
      builder: (context) {
        return 
              AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height / 8,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.error,
                          color: Theme.of(context).accentColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2.1,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  text,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              25,
                                      color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              InkWell(
                child: Container(
                  height: MediaQuery.of(context).size.height / 20,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Material(
                    color: Theme.of(context).accentColor,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                        child: Text(
                          EasyLocalization.of(context).locale == Locale('en')
                              ? "cancel"
                              : "الغاء",
                          style: TextStyle(
                              color: Colors.grey[50],
                              fontSize: MediaQuery.of(context).size.width / 23),
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              InkWell(
                child: Container(
                  height: MediaQuery.of(context).size.height / 20,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Material(
                    color: Theme.of(context).accentColor,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                        child: Text(
                          EasyLocalization.of(context).locale == Locale('en')
                              ? "ok"
                              : "حسنا",
                          style: TextStyle(
                              color: Colors.grey[50],
                              fontSize: MediaQuery.of(context).size.width / 23),
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  sendOrder();

                  
                },
              )
            ],
         
        );
      },
    );
  }


    Widget buildSwitchLanguege(
      {BuildContext context, String title, String subtitle, Locale locale}) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
              locale == Locale('ar') ?  "Change Language" : "تغيير اللغة",
                style: Theme.of(context).textTheme.title
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.title,
            ),
          ],
        ),
      ),
      onTap: () {
        log(locale.toString(), name: toString());
        EasyLocalization.of(context).locale = locale;
                   Navigator.pushAndRemoveUntil(
                                context, MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                                 ( Route<dynamic> route) => false);
      },
    );
  }






}
