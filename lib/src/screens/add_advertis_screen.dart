import 'package:elfhad/ConstantVarables.dart';
import 'package:elfhad/src/controllers/AddsController.dart';
import 'package:elfhad/src/controllers/CategoryController.dart';
import 'package:elfhad/src/controllers/UserController.dart';
import 'package:elfhad/src/controllers/UserLocalStorage.dart';
import 'package:elfhad/src/data/models/AreaMenu.dart';
import 'package:elfhad/src/data/models/CityMenu.dart';
import 'package:elfhad/src/data/models/SectionsModel.dart';
import 'package:elfhad/src/data/models/SubSectionModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elfhad/src/widgets/AppBarWidget.dart';
import 'package:elfhad/src/widgets/SharedWidget.dart';
import 'package:elfhad/src/widgets/TextFormFieldW.dart';
import 'package:elfhad/src/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AddadvertisScreen extends StatefulWidget {
  final String title;
  String updateOrAdd;
  AddadvertisScreen({this.title, this.updateOrAdd});
  createState() => AddadvertisView();
}

class AddadvertisView extends StateMVC<AddadvertisScreen> {
  AddadvertisView() : super(AddsController()) {
    addsController = AddsController.con;
  }

  AddsController addsController;

  CityMenu selectedCityMenu;
  AreaMenu selectedAreaMenu;
  SubSectionsModel selectedSubCategory;
  SectionsModel selectedCategory;
//  String dropDownTitleAreaMenu = "_chose_area".tr();
  String dropDownTitleCityMenu = "_chose_area".tr();
  String dropDownTitleCategory = "_chose_section".tr();
  String dropDownTitleSubCategory = "_chose_subSection".tr();

  bool isloading = false;
  final GlobalKey<ScaffoldState> _scaffoldKeyHome =
      new GlobalKey<ScaffoldState>();
  Widget menu() {
    return IconButton(
        icon: Icon(
          Icons.menu,
          size: 30,
          color: Theme.of(context).accentColor,
        ),
        onPressed: () {
          _scaffoldKeyHome.currentState.openDrawer();
        });
  }

  @override
  void initState() {
    addsController.getAllCities();
    addsController.getAllRegions("2");
    CategoryController().getAllSectionMenuButton();
    CategoryController().getAllSubSectionMenuButton("2");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyHome,
      appBar: AppBarWidget().showAppBar(context, "_add_adds".tr(), menu(), false),
      drawer: DrawerW().showDrawer(context, _scaffoldKeyHome),
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Form(
                key: ConstantVarable.addAddsFormKey,
                autovalidate: ConstantVarable.addAddsAutoValid,
                child: Column(
                  children: <Widget>[
                    TextFormFieldW(
                      textInputType: TextInputType.text,
                      controller: ConstantVarable.nameArController,
                      validator: (val) =>
                          UserController().validateAnyFeild( context , val),
                      image: "assets/imgs/user.png",
                      hintText: "_add_address_ar".tr(),
                      obSecureText: false,
                    ),
                    Container(
                      height: 16,
                    ),
                    TextFormFieldW(
                      textInputType: TextInputType.text,
                      controller: ConstantVarable.nameEnController,
                      validator: (val) =>
                          UserController().validateAnyFeild( context , val),
                      image: "assets/imgs/user.png",
                      hintText: "_add_address_en".tr(),
                      obSecureText: false,
                    ),
                    Container(
                      height: 16,
                    ),
                    TextFormFieldW(
                      textInputType: TextInputType.text,
                      controller: ConstantVarable.describeArController,
                      validator: (val) =>
                          UserController().validateAnyFeild( context , val),
                      image: "assets/imgs/user.png",
                      hintText: "_add_descrip_ar".tr(),
                      obSecureText: false,
                    ),

                    Container(
                      height: 16,
                    ),

                    TextFormFieldW(
                      textInputType: TextInputType.text,
                      controller: ConstantVarable.describeEnController,
                      validator: (val) =>
                          UserController().validateAnyFeild( context , val),
                      image: "assets/imgs/user.png",
                      hintText: "_add_descrip_en".tr(),
                      obSecureText: false,
                    ),
                    Container(
                      height: 16,
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: <Widget>[
                          DropdownButton<SectionsModel>(
                              hint: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Text(dropDownTitleCategory , style: Theme.of(context).textTheme.caption,),
                              ),
                              underline: Container(),
                              value: selectedCategory,
                              iconSize: 0,
                              icon: Image.asset(
                                "assets/imgs/arrow_down.png",
                                width: 15,
                                height: 15,
                              ),
                              items: CategoryController()
                                  .sectionList
                                  .map((SectionsModel category) {
                                return DropdownMenuItem<SectionsModel>(
                                    value: category,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              category.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline,
                                            ),
                                            Expanded(
                                              child: Container(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                              }).toList(),
                              onChanged: (SectionsModel value) {
                                setState(() {
                                  selectedCategory = value;
                                  dropDownTitleCategory = value.name;
                                  ConstantVarable.sectionId = value.id;
                                  print("category id is :: " +
                                      ConstantVarable.sectionId);
                                  CategoryController()
                                      .getAllSubSectionMenuButton(value.id);
                                });
                              })
                        ],
                      ),
                    ),
                    Container(
                      height: 16,
                    ),

                    StreamBuilder(
                        stream: CategoryController()
                            .getAllSubSectionMenuStream
                            .stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<SubSectionsModel> subSectionList =
                                List<SubSectionsModel>();
                            List<dynamic> data = snapshot.data;

                            for (int i = 0; i < data.length; i++) {
                              subSectionList.add(SubSectionsModel(
                                  id: data[i]["id"], name: data[i]["id"]));
                            }

                            print("sub section list is" +
                                subSectionList.toString());
                            return Container(
                              width: MediaQuery.of(context).size.width / 1.1,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                children: <Widget>[
                                  DropdownButton<SubSectionsModel>(
                                      hint: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Text(dropDownTitleSubCategory , style: Theme.of(context).textTheme.caption,),
                                      ),
                                      underline: Container(),
                                      value: selectedSubCategory,
                                      iconSize: 0,
                                      icon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 0),
                                        child: Image.asset(
                                          "assets/imgs/arrow_down.png",
                                          width: 15,
                                          height: 15,
                                        ),
                                      ),
                                      items: CategoryController()
                                          .subSectionList
                                          .map((SubSectionsModel subCategory) {
                                        return DropdownMenuItem<
                                                SubSectionsModel>(
                                            value: subCategory,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 8),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.5,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      subCategory.name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline,
                                                    ),
                                                    Expanded(
                                                      child: Container(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ));
                                      }).toList(),
                                      onChanged: (SubSectionsModel value) {
                                        setState(() {
                                          selectedSubCategory = value;
                                          dropDownTitleSubCategory = value.name;
                                          ConstantVarable.subSectionId =
                                              value.id;
                                          print("sub section id is :: " +
                                              ConstantVarable.subSectionId);
                                        });
                                      })
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }),

                    Container(
                      height: 16,
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.white),
                          
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: <Widget>[
                          DropdownButton<CityMenu>(
                              hint: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Text(dropDownTitleCityMenu , style: Theme.of(context).textTheme.caption,),
                              ),
                              underline: Container(),
                              value: selectedCityMenu,
                              iconSize: 0,
                              icon: Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: Image.asset(
                                  "assets/imgs/arrow_down.png",
                                  width: 15,
                                  height: 15,
                                ),
                              ),
                              items: addsController.cities
                                  .map((CityMenu subCategory) {
                                return DropdownMenuItem<CityMenu>(
                                    value: subCategory,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              subCategory.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline,
                                            ),

                                            Expanded(
                                              child: Container(),
                                            ),

                                            // Image.asset("assets/imgs/arrow_down.png" , width: 20,height: 20,)
                                          ],
                                        ),
                                      ),
                                    ));
                              }).toList(),
                              onChanged: (CityMenu value) {
                                setState(() {
                                  selectedCityMenu = value;
                                  dropDownTitleCityMenu = value.name;
                                  ConstantVarable.cityId = value.id;
                                  addsController.getAllRegions(ConstantVarable.cityId);
                                });
                              })
                        ],
                      ),
                    ),
//
//                    Container(
//                      height: 16,
//                    ),
//
//                    StreamBuilder(
//                      stream: addsController.getAreaStream.stream,
//                        builder: (context , snapshot){
//                          if(snapshot.hasData){
//                            return      Container(
//                              width: MediaQuery.of(context).size.width / 1.1,
//                              decoration: BoxDecoration(
//                                  color: Colors.black,
//                                  border: Border.all(color: Colors.white),
//
//                                  borderRadius: BorderRadius.circular(12)),
//                              child: Row(
//                                children: <Widget>[
//                                  DropdownButton<AreaMenu>(
//                                      hint: Padding(
//                                        padding:
//                                        const EdgeInsets.only(left: 8, right: 8),
//                                        child: Text(dropDownTitleAreaMenu , style: Theme.of(context).textTheme.caption,),
//                                      ),
//                                      underline: Container(),
//                                      value: selectedAreaMenu,
//                                      iconSize: 0,
//                                      icon: Padding(
//                                        padding: const EdgeInsets.only(right: 0),
//                                        child: Image.asset(
//                                          "assets/imgs/arrow_down.png",
//                                          width: 15,
//                                          height: 15,
//                                        ),
//                                      ),
//                                      items: addsController.regions
//                                          .map((AreaMenu areaMenu) {
//                                        return DropdownMenuItem<AreaMenu>(
//                                            value: areaMenu,
//                                            child: Padding(
//                                              padding: const EdgeInsets.only(
//                                                  left: 8, right: 8),
//                                              child: Container(
//                                                width:
//                                                MediaQuery.of(context).size.width /
//                                                    1.5,
//                                                child: Row(
//                                                  mainAxisAlignment:
//                                                  MainAxisAlignment.spaceBetween,
//                                                  children: <Widget>[
//                                                    Text(
//                                                      areaMenu.name,
//                                                      style: Theme.of(context)
//                                                          .textTheme
//                                                          .headline,
//                                                    ),
//
//                                                    Expanded(
//                                                      child: Container(),
//                                                    ),
//
//                                                    // Image.asset("assets/imgs/arrow_down.png" , width: 20,height: 20,)
//                                                  ],
//                                                ),
//                                              ),
//                                            ));
//                                      }).toList(),
//                                      onChanged: (AreaMenu value) {
//                                        setState(() {
//                                          selectedAreaMenu = value;
//                                          dropDownTitleAreaMenu = value.name;
//
//                                        });
//                                      })
//                                ],
//                              ),
//                            );
//                          }else{
//                            return SharedWidget.loading(context);
//                          }
//                        }),



                    Container(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          imageAdvertis(),
                        ],
                      ),
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
                                      widget.updateOrAdd == "add"
                                          ? "_add".tr()
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
                                isloading = true;
                              });
                              UserLocalStorage().getUser().then((user) {
                                addsController
                                    .addAdvertiseLogic(
                                        context,
                                        ConstantVarable.subSectionId,
                                        ConstantVarable.nameArController.text,
                                        ConstantVarable.nameEnController.text,
                                        ConstantVarable
                                            .describeArController.text,
                                        ConstantVarable
                                            .describeEnController.text,
                                        user.id,
                                        ConstantVarable.cityId,
                                        addsController.imageAdd)
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

  @override
  void dispose() {
    super.dispose();
  }

  Widget imageAdvertis() {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
           width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
            ),
            child: addsController.imageAdd == null
                ? Container(
                  child: Image.asset("assets/imgs/file-upload.png"),
                )

                : addsController.imageAdd != null
                    ? Container(
                       height: 100,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          image: DecorationImage(
                            image: FileImage(addsController.imageAdd) , fit: BoxFit.cover)
                        ),
                      )
                    : Card(
                        shape: CircleBorder(),
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            child: Container(
                              child: Image.asset(
                                'assets/imgs/ic_upload_avatar.png',
                                height: 300,
                              ),
                            ))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: RaisedButton(
            shape: CircleBorder(),
            child: Icon(Icons.add_a_photo),
            onPressed: () {
              addsController.getImageAdd();
            },
          ),
        )
      ],
    );
  }
}
