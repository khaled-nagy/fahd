import 'package:elfhad/ConstantVarables.dart';
import 'package:elfhad/src/controllers/UserController.dart';
import 'package:elfhad/src/controllers/UserLocalStorage.dart';
import 'package:elfhad/src/screens/add_advertis_screen.dart';
import 'package:elfhad/src/screens/home_screen.dart';
import 'package:elfhad/src/screens/login_screen.dart';
import 'package:elfhad/src/screens/user_adds_screen.dart';
import 'package:elfhad/src/widgets/SharedWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elfhad/src/screens/contact_us_screen.dart';
import 'package:elfhad/src/screens/about_app_screen.dart';
import 'package:elfhad/src/screens/who_are_we.dart';

class DrawerW {
  Widget showDrawer(
    BuildContext context,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.1,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Drawer(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(30)),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/imgs/cancel.png"),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/imgs/logo.png"))),
                          ),
                          Text(
                            ConstantVarable.userName == null
                                ? "_user_name".tr()
                                : ConstantVarable.userName,
                            style: Theme.of(context).textTheme.title,
                          ),
                          InkWell(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 8),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/imgs/browser.png"))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 8),
                                    child: Text(
                                      "_home".tr(),
                                      style: Theme.of(context).textTheme.title,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            },
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Divider(
                                color: Color(0xFF59432A),
                              )),
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/imgs/add.png"))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      "_add_adds".tr(),
                                      style: Theme.of(context).textTheme.title,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {

                              Navigator.pop(context);
                    

                              UserLocalStorage().getUser().then((user) {
                                if (user.email == null) {

                                  SharedWidget.logOutAlertDialog(context, "_login".tr(), (){
                                       Navigator.pushAndRemoveUntil(
                                context, MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                                 ( Route<dynamic> route) => false);
                                  });
                               
                                } else {

   Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddadvertisScreen(
                                                updateOrAdd: "add",
                                              )));
                                }
                              });
                            },
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Divider(
                                color: Color(0xFF59432A),
                              )),
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/imgs/megaphone.png"))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      "_my_adds".tr(),
                                      style: Theme.of(context).textTheme.title,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);

                              UserLocalStorage().getUser().then((user) {
                                if (user.email == null) {

                                  SharedWidget.logOutAlertDialog(context, "_login".tr(), (){
                                       Navigator.pushAndRemoveUntil(
                                context, MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                                 ( Route<dynamic> route) => false);
                                  });
                               
                                } else {

   Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserAddsScreen(
                                                title: "_my_adds".tr(),
                                              )));
                                }
                              });
                            },
                          ),
                      
                            Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Divider(
                                color: Color(0xFF59432A),
                              )),
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/imgs/contact-us.png"))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      "_contact_us".tr(),
                                      style: Theme.of(context).textTheme.title,
                                    ),
                                  ),
                                  Container(
                                    width: 45,
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContactUsScreen(
                                           
                                          )));
                            },
                          ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Divider(
                                color: Color(0xFF59432A),
                              )),
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/imgs/help.png"))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      "_about_app".tr(),
                                      style: Theme.of(context).textTheme.title,
                                    ),
                                  ),
                                  Container(
                                    width: 45,
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AboutAppScreen(
                                            
                                          )));
                            },
                          ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Divider(
                                color: Color(0xFF59432A),
                              )),
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/imgs/question.png"))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      "_who_are_we".tr(),
                                      style: Theme.of(context).textTheme.title,
                                    ),
                                  ),
                                  Container(
                                    width: 45,
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WhoAreWeScreen(
                                         
                                          )));
                            },
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Divider(
                                color: Color(0xFF59432A),
                              )),

                                     EasyLocalization.of(context).locale ==
                                        Locale('en') ?
                                       
                                    SharedWidget().buildSwitchLanguege(
                                        context: context,
                                        title: 'English',
                                        subtitle: 'English',
                                        locale: EasyLocalization.of(context)
                                            .supportedLocales[1]):
                                              SharedWidget(). buildSwitchLanguege(
                                        context: context,
                                        title: 'عربى',
                                        subtitle: 'عربى',
                                        locale: EasyLocalization.of(context)
                                            .supportedLocales[0]),
                                               Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Divider(
                                color: Color(0xFF59432A),
                              )),
                          InkWell(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8, bottom: 30),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                            ConstantVarable.userId == "_user_name".tr() ?
                                             AssetImage(
                                                "assets/imgs/login.png"):
                                                  AssetImage(
                                                "assets/imgs/logout.png")
                                                )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      ConstantVarable.userName == "_user_name".tr() ?
                                      "_login".tr() :
                                      "_logout".tr(),
                                      style: Theme.of(context).textTheme.title,
                                    ),
                                  ),
                                  Container(
                                    width: 45,
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              UserController().logOut();

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                // (Route<dynamic> route) => false
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ICONS
          ),
        ),
      ),
    );
  }
}
