import 'package:elfhad/src/controllers/UserController.dart';
import 'package:elfhad/src/screens/forgot_password_screen.dart';
import 'package:elfhad/src/screens/home_screen.dart';
import 'package:elfhad/src/screens/register_screen.dart';
import 'package:elfhad/src/widgets/SharedWidget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:elfhad/ConstantVarables.dart';
import 'package:elfhad/src/widgets/TextFormFieldW.dart';
import 'package:easy_localization/easy_localization.dart';


class LoginScreen extends StatefulWidget {
  createState() => LoginView();
}

class LoginView extends StateMVC<LoginScreen> {
  LoginView() : super(UserController()) {
    _userController = UserController.con;
  }

  UserController _userController;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //endDrawer: DrawerW().showDrawerUser(context),
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                ),
                child: Image.asset(
                  "assets/imgs/logo.png",
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.height / 3,
                ),
              ),
              Container(
                height: 33,
              ),
              Form(
                key: ConstantVarable.loginformKey,
                autovalidate: ConstantVarable.loginAutoValid,
                child: Column(
                  
                  children: <Widget>[
                    TextFormFieldW(
                      textInputType: TextInputType.emailAddress,
                      controller: ConstantVarable.emailController,
                      validator: (val) => _userController.validateEmail(val),
                      image: "assets/imgs/user.png",
                      hintText: "_email".tr(),
                      obSecureText: false,
                    ),
                    Container(
                      height: 15,
                    ),
                    TextFormFieldW(
                      textInputType: TextInputType.text,
                      controller: ConstantVarable.passwordController,
                      validator: (val) => _userController.validatePassword(val),
                      image: "assets/imgs/lock.png",
                      hintText: "_pass".tr(),
                      obSecureText: true,
                    ),
                     Container(
                      height: 16,
                    ),
                    _userController.showErrorMsg(),
                    Container(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        isloading == false ?
                        InkWell(
                          child: Container(
                            height: 45.0,
                            width: MediaQuery.of(context).size.width / 3,
                            child: Material(
                                color: Theme.of(context).accentColor,
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Center(
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 0.0, bottom: 10.0),
                                        child: Text(
                                          "_enter".tr(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                             ),
                                        )))),
                          ),
                          onTap: () {
                            // Navigator.pushAndRemoveUntil(
                            //   context, MaterialPageRoute(
                            //     builder: (context) => HomeScreen()),
                            //    ( Route<dynamic> route) => false);

                            setState(() {
                              isloading = true ;
                             });
                      _userController.signInWithEmailAndPassword(
                        context,
                         ConstantVarable.emailController.text,
                          ConstantVarable.passwordController.text,
                       
                          ).then((done) {
                            if(done== true){
                              setState(() {
                              isloading = false ;
                             });
                            }else{
                               setState(() {
                              isloading = false ;
                             });
                            }
                          });
                          },
                        ):
                        SharedWidget.loading(context),
                        InkWell(
                          child: Container(
                            height: 30,
                            child: Text(
                              "_forgot_pass".tr(),
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 14.0,
                                  ),
                            ),
                          ),
                          onTap: () {
                            _userController.clearTextFields();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ForgotPasswordScreen()));
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: InkWell(
                            child: Container(
                              height: 45.0,
                              width: MediaQuery.of(context).size.width ,
                              child: Material(
                                  color: Theme.of(context).accentColor,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Center(
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 0.0, bottom: 10.0),
                                          child: Text(
                                            "_contenu".tr(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                               ),
                                          )))),
                            ),
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context, MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                                 ( Route<dynamic> route) => false);

                           
                      
                            },
                          ),
                  ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 30,
                      child: Text(
                        "_dont_have_account".tr(),
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    Container(
                      width: 8,
                    ),
                    InkWell(
                      child: Container(
                        height: 30,
                        child: Text(
                          "_creat_account".tr(),
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                         _userController.clearTextFields();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    RegisterScreen(
                                      registerOrModify: "register",
                                    )));
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

}
