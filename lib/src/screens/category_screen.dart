import 'package:elfhad/ConstantVarables.dart';
import 'package:elfhad/src/controllers/CategoryController.dart';
import 'package:elfhad/src/data/models/SubSectionModel.dart';
import 'package:elfhad/src/widgets/AppBarWidget.dart';
import 'package:elfhad/src/widgets/CategoryCard.dart';
import 'package:elfhad/src/widgets/SharedWidget.dart';
import 'package:elfhad/src/widgets/drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:easy_localization/easy_localization.dart';

class CategoryScreen extends StatefulWidget {
  String title;
  String categoryId;
  CategoryScreen({this.title, this.categoryId});
  createState() => CategoryView();
}

class CategoryView extends StateMVC<CategoryScreen> {
  CategoryView() : super(CategoryController()) {
    categoryController = CategoryController.con;
  }

  CategoryController categoryController;

  String dropDownTitleSubCategory = "_chose_section".tr();

  SubSectionsModel selectedSubCategory;

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
    ConstantVarable.allAddsOrOne = false;
    print(widget.title);
    print(widget.categoryId);
    categoryController.getSubSections(widget.categoryId);
    categoryController.getAllSubSectionMenuButton(widget.categoryId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyHome,
      appBar: AppBarWidget().showAppBar(context, widget.title, menu(), false),
      drawer: DrawerW().showDrawer(context, _scaffoldKeyHome),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 16,
            ),
            Container(
              height: 16,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: <Widget>[
                  DropdownButton<SubSectionsModel>(
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text(dropDownTitleSubCategory),
                      ),
                      underline: Container(),
                      value: selectedSubCategory,
                      iconSize: 0,
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Image.asset(
                          "assets/imgs/arrow_down.png",
                          width: 15,
                          height: 15,
                        ),
                      ),
                      items: categoryController.subSectionList
                          .map((SubSectionsModel subCategory) {
                        return DropdownMenuItem<SubSectionsModel>(
                            value: subCategory,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      subCategory.name,
                                      style:
                                          Theme.of(context).textTheme.headline,
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
                          ConstantVarable.allAddsOrOne = true;
                          selectedSubCategory = value;
                          dropDownTitleSubCategory = value.name;
                          categoryController
                              .getSubSectionsBySectionId(value.id);
                        });
                      })
                ],
              ),
            ),
            Container(
              height: 16,
            ),
            StreamBuilder(
                stream: ConstantVarable.allAddsOrOne == false
                    ? categoryController.getSubSectionsStream.stream
                    : categoryController.getSubSectionsBySectionIdStream.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return subSectionsList(snapshot.data);
                  } else {
                    print(snapshot.data == null);
                    if (snapshot.data == null) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Center(
                          child: Text(
                            "_no_data_fonded".tr(),
                            style: Theme.of(context).textTheme.display4,
                          ),
                        ),
                      );
                    } else {
                      return SharedWidget.loading(context);
                    }
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget subSectionsList(List data) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return CategoryCard(
            index: index,
            title: widget.title,
            data: data[index],
          );
        });
  }
}
