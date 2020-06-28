import 'dart:io';

import 'package:elfhad/src/controllers/UserController.dart';
import 'package:elfhad/ConstantVarables.dart';
import 'package:elfhad/src/widgets/SharedWidget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:elfhad/src/widgets/TextFormFieldW.dart';

class RegisterScreen extends StatefulWidget {
  final String registerOrModify;
  RegisterScreen({this.registerOrModify});
  createState() => RegisterView();
}

class RegisterView extends StateMVC<RegisterScreen> {
  RegisterView() : super(UserController()) {
    _userController = UserController.con;
  }
  UserController _userController;
  bool isLoading = false;
  File imageProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 16,
              ),
              widget.registerOrModify == "register"
                  ? Image.asset(
                      "assets/imgs/logo.png",
                      width: MediaQuery.of(context).size.width / 1.7,
                    )
                  : InkWell(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: imageProfile == null
                            ? AssetImage("assets/imgs/advimage1@3x.png")
                            : FileImage(imageProfile),
                      ),
                      onTap: () {
// getimageProfile();
                      },
                    ),
              widget.registerOrModify == "register"
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 16, top: 16),
                      child: Text(
                        "_reg_message".tr(),
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold , color: Theme.of(context).accentColor),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 16, top: 16),
                      child: Text(
                        "_update_data".tr(),
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
              Form(
                key: ConstantVarable.regformKey,
                autovalidate: ConstantVarable.regAutoValid,
                child: Column(
                  children: <Widget>[
                    TextFormFieldW(
                      textInputType: TextInputType.text,
                      controller: ConstantVarable.userNameController,
                      validator: (val) => _userController.validateUserName(val),
                      image: "assets/imgs/user.png",
                      hintText: "_user_name".tr(),
                      obSecureText: false,
                    ),
                    Container(
                      height: 16,
                    ),
                    TextFormFieldW(
                      textInputType: TextInputType.emailAddress,
                      controller: ConstantVarable.emailController,
                      validator: (val) => _userController.validateEmail(val),
                      image: "assets/imgs/user.png",
                      hintText: "_email".tr(),
                      obSecureText: false,
                    ),
                    Container(
                      height: 16,
                    ),
                      TextFormFieldW(
                      textInputType: TextInputType.number,
                      controller: ConstantVarable.phoneController,
                      validator: (val) => _userController.validatePhone(val),
                      image: "assets/imgs/phone.png",
                      hintText: "_phone".tr(),
                      obSecureText: false,
                    ),
                    Container(
                      height: 16,
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
                    TextFormFieldW(
                      textInputType: TextInputType.text,
                      controller: ConstantVarable.confirmPasswordController,
                      validator: (val) =>
                          _userController.validateConfirmPassword(val),
                      image: "assets/imgs/lock.png",
                      hintText: "_confirm_pass".tr(),
                      obSecureText: true,
                    ),
                    _userController.showErrorMsg(),
                    Container(
                      height: 16,
                    ),
                    isLoading==false ?
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
                              padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                              child: Text(
                                widget.registerOrModify == "register"
                                    ? "_register".tr()
                                    : "_update_data".tr(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                   ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                          setState(() {
                              isLoading = true ;
                             });
                        _userController.regNewUser(
                          context,
                         ConstantVarable.userNameController.text,
                          ConstantVarable.passwordController.text,
                           ConstantVarable.emailController.text,
                           "aaa",
                            ConstantVarable.phoneController.text).then((done) {
                                if(done== true){
                              setState(() {
                              isLoading = false ;
                             });
                            }else{
                               setState(() {
                              isLoading = false ;
                             });
                            }
                            });
                      },
                    ):
                    SharedWidget.loading(context),
                    Container(
                      height: 16,
                    ),
                  
                  ],
                ),
              ),
              widget.registerOrModify == "register"
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "_are_you_have_account".tr(),
                            style: Theme.of(context).textTheme.caption,
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              child: Text(
                                "_login".tr(),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onTap: () {
                              _userController.clearTextFields();
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    )
                  : Text(""),
            ],
          ),
        ),
      ),
    );
  }
    @override
  void dispose() {
    
    super.dispose();
  }
  //   Future getimageProfile() async {
  //   var imagex = await ImagePicker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     imageProfile = imagex;
  //   });
  //   refresh();

  //   imageProfile.exists().then((yas) {
  //     print(yas);
  //     if (yas) {
  //       //  updateImage();
  //     }
  //   });
  // }
}
