import 'package:elfhad/ConstantVarables.dart';
import 'package:elfhad/src/controllers/UserController.dart';
import 'package:elfhad/src/widgets/AppBarWidget.dart';
import 'package:elfhad/src/widgets/SharedWidget.dart';
import 'package:elfhad/src/widgets/TextFormFieldW.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:elfhad/src/controllers/InformationController.dart';
import 'package:easy_localization/easy_localization.dart';

class ContactUsScreen extends StatefulWidget {
  createState() => ContactUsView();
}

class ContactUsView extends StateMVC<ContactUsScreen> {
  ContactUsView() : super(InformationController()) {
    _informationController = InformationController.con;
  }

  InformationController _informationController;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //endDrawer: DrawerW().showDrawerUser(context),
      appBar: AppBarWidget()
          .showAppBar(context, "_contact_us".tr(), Container(), false),
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                  bottom: 16
                ),
                child: Image.asset(
                  "assets/imgs/logo.png",
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 6,
                ),
              ),
              Form(
                key: ConstantVarable.sendMessageFormKey,
                autovalidate: ConstantVarable.sendMessageAutoValid,
                child: Column(
                  children: <Widget>[
                    TextFormFieldW(
                      textInputType: TextInputType.text,
                      controller: ConstantVarable.userNameController,
                      validator: (val) =>
                          UserController().validateAnyFeild(context , val),
                      image: "assets/imgs/user.png",
                      hintText: "_user_name".tr(),
                      obSecureText: false,
                    ),
                    Container(
                      height: 16,
                    ),
                    TextFormFieldW(
                      textInputType: TextInputType.text,
                      controller: ConstantVarable.nameEnController,
                      validator: (val) =>
                          UserController().validateAnyFeild(context , val),
                      image: "assets/imgs/user.png",
                      hintText: "_title".tr(),
                      obSecureText: false,
                    ),
                    Container(
                      height: 16,
                    ),
                    TextFormFieldW(
                      textInputType: TextInputType.number,
                      controller: ConstantVarable.phoneController,
                      validator: (val) =>
                          UserController().validateAnyFeild(context , val),
                      image: "assets/imgs/phone.png",
                      hintText: "_phone".tr(),
                      obSecureText: false,
                    ),

                    Container(
                      height: 16,
                    ),

                    TextFormFieldW(
                      textInputType: TextInputType.text,
                      controller: ConstantVarable.describeEnController,
                      validator: (val) =>
                          UserController().validateAnyFeild(context , val),
                      image: "assets/imgs/user.png",
                      hintText: "_address".tr(),
                      obSecureText: false,
                    ),
                    Container(
                      height: 16,
                    ),
                    TextFormFieldW(
                      textInputType: TextInputType.text,
                      controller: ConstantVarable.messageController,
                      validator: (val) =>
                          UserController().validateAnyFeild(context , val),
                      image: "assets/imgs/whatsapp.png",
                      hintText: "_message".tr(),
                      obSecureText: false,
                    ),
                    Container(
                      height: 16,
                    ),

                    // _userController.showErrorMsg(),
                    Container(
                      height: 16,
                    ),
                    isloading == false
                        ? InkWell(
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
                                    padding:
                                        EdgeInsets.only(top: 0.0, bottom: 0.0),
                                    child: Text(
                                      "_send".tr(),
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
                                isloading = true;
                              });

                              _informationController
                                  .sendMessageLogic(
                                context,
                                ConstantVarable.userNameController.text,
                                ConstantVarable.nameEnController.text,
                                ConstantVarable.phoneController.text,
                                ConstantVarable.describeEnController.text,
                                ConstantVarable.messageController.text,
                              )
                                  .then((done) {
                                if (done == true) {
                                  setState(() {
                                    isloading = false;
                                  });
                                } else {
                                  setState(() {
                                    isloading = false;
                                  });
                                }
                              });
                            },
                          )
                        : SharedWidget.loading(context),
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
}
