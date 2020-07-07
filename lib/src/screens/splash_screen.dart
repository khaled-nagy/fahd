import 'dart:async';


import 'package:elfhad/ConstantVarables.dart';
import 'package:elfhad/src/controllers/UserLocalStorage.dart';
import 'package:elfhad/src/screens/home_screen.dart';
import 'package:elfhad/src/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      UserLocalStorage().getUser().then((user) {
if(user.email != null ){
  ConstantVarable.userName = user.name ;
  ConstantVarable.userId = user.id ;
  Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context)=> HomeScreen()));
}else{
    ConstantVarable.userName = "_user_name".tr() ;
  ConstantVarable.userId = user.id ;
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context)=> HomeScreen()));

}
      });
  
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          
          image: DecorationImage(
              image: AssetImage("assets/imgs/splash.png"),
              fit: BoxFit.cover)),
      // child: Center(
      //   child: Container(
      //     decoration: BoxDecoration(color: Colors.white),
      //     width: MediaQuery.of(context).size.width / 3,
      //     height: MediaQuery.of(context).size.height / 6,
      //     child: Image.asset("assets/imgs/playstore.png"),
      //   ),
      // ),
    ));
  }
}
