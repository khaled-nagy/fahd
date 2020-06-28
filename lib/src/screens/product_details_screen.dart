import 'package:carousel_slider/carousel_slider.dart';
import 'package:elfhad/src/controllers/CategoryController.dart';
import 'package:elfhad/src/widgets/AppBarWidget.dart';
import 'package:elfhad/src/widgets/SharedWidget.dart';
import 'package:elfhad/src/widgets/drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:share/share.dart';


class ProdeuctDetailsScreen extends StatefulWidget {
  final String title;
  final String subCategoryId;
  ProdeuctDetailsScreen({this.title, this.subCategoryId});
  createState() => CategoryView();
}

class CategoryView extends StateMVC<ProdeuctDetailsScreen> {
  CategoryView() : super(CategoryController()) {
    categoryController = CategoryController.con;
  }

  CategoryController categoryController;

  List<String> galleryList = <String>[
    "assets/imgs/Group_35.png",
    "assets/imgs/Group_36.png",
    "assets/imgs/Group_37.png",
    "assets/imgs/Group_38.png",
    "assets/imgs/Group_39.png",
    "assets/imgs/Group_40.png",
  ];

  final GlobalKey<ScaffoldState> _scaffoldKeyHome =
      new GlobalKey<ScaffoldState>();

  final CarouselController buttonCarouselController = CarouselController();
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
    print(widget.title);
    print(widget.subCategoryId);
    categoryController.getSubCategoryDetails(widget.subCategoryId);
    print("ggggg" + categoryController.dataDetails.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyHome,
      // bottomSheet:  bottomSheet(
      //   categoryController.dataDetails['Email'] == null ? "" : categoryController.dataDetails['Email'],
      //    categoryController.dataDetails['Mobile']== null ? "" : categoryController.dataDetails['Mobile'],
      //    categoryController.dataDetails['Email']== null ? "" : categoryController.dataDetails['Email'],),
      appBar: AppBarWidget().showAppBar(context, widget.title, menu(), false),
      drawer: DrawerW().showDrawer(context, _scaffoldKeyHome),
      body: StreamBuilder(
          stream: categoryController.subCategoryDetailsStream.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<dynamic> gallery = snapshot.data[0]['Image'];
              Map<String, dynamic> data = snapshot.data[0];
              print("gallery list is : " + gallery.toString());
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 16,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            data['Name'] == null ? "" : data['Name'],
                            style: Theme.of(context).textTheme.display4,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16, top: 8),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 1.7,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/imgs/location.png",
                                          width: 10,
                                          height: 10,
                                        ),
                                        Container(
                                          width: 2,
                                        ),
                                        Text(
                                            data['City'] == null
                                                ? ""
                                                : data['City'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .body2)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/imgs/time.png",
                                          width: 10,
                                          height: 10,
                                        ),
                                        Container(
                                          width: 2,
                                        ),
                                        Text(
                                            data['AcceptedAtTime'] == null
                                                ? ""
                                                : data['AcceptedAtTime'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .body2)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/imgs/profile.png",
                                          width: 10,
                                          height: 10,
                                        ),
                                        Container(
                                          width: 2,
                                        ),
                                        Text(
                                            data['user'] == null
                                                ? ""
                                                : data['user'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .body2)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: CarouselSlider(
                              items: gallery.map((image) {
                                return Builder(builder: (context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 10),
                                        image: DecorationImage(
                                            image: NetworkImage(image),
                                            fit: BoxFit.cover)),
                                  );
                                });
                              }).toList(),
                              carouselController: buttonCarouselController,
                              options: CarouselOptions(
                                autoPlay: false,
                                enlargeCenterPage: false,
                                viewportFraction: 1.0,
                                initialPage: 2,
                                // aspectRatio: 16.9/9.8
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              child: Image.asset(
                                "assets/imgs/Shape 38.png",
                                width: 70,
                                height: 70,
                              ),
                              onTap: () {
                                buttonCarouselController.previousPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.linear);
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              child: Image.asset(
                                  "assets/imgs/Shape 38 copy.png",
                                  width: 70,
                                  height: 70),
                              onTap: () {
                                buttonCarouselController.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.linear);
                              },
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        height: 70,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: gallery.length,
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: InkWell(
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(gallery[index]),
                                            fit: BoxFit.cover),
                                        border: Border.all(
                                            color: Colors.white, width: 2)),
                                  ),
                                  onTap: () {
                                    buttonCarouselController.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.linear);
                                    buttonCarouselController
                                        .animateToPage(index);
                                  },
                                ),
                              );
                            }),
                      ),
                      Container(
                        height: 16,
                      ),
                      Container(
                        constraints: BoxConstraints(
                          minHeight: 200,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data['Describe'] == null ? "" : data['Describe'],
                              style: Theme.of(context).textTheme.display1,
                            ),
                          ],
                        ),
                      ),
                      bottomSheet(
                          categoryController.dataDetails['Email'] == null
                              ? ""
                              : categoryController.dataDetails['Email'],
                          categoryController.dataDetails['Mobile'] == null
                              ? ""
                              : categoryController.dataDetails['Mobile'],
                          categoryController.dataDetails['Email'] == null
                              ? ""
                              : categoryController.dataDetails['Email'],
                          data['Name'] == null ? "" : data['Name'],
                          gallery[0])
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: SharedWidget.loading(context),
              );
            }
          }),
    );
  }

  Widget bottomSheet(
      String urlMail, String urlPhone, String urlTwiter, String title, image) {
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              child: Image.asset(
                "assets/imgs/mail.png",
                width: 35,
                height: 35,
              ),
              onTap: () {
                // _shareImageAndText(title , image );
                share(context, title, image);
              },
            ),
            InkWell(
              child: Image.asset(
                "assets/imgs/heart.png",
                width: 35,
                height: 35,
              ),
              onTap: () {
                share(context, title, image);
              },
            ),
            InkWell(
              child: Image.asset(
                "assets/imgs/whatsapp.png",
                width: 35,
                height: 35,
              ),
              onTap: () {
                share(context, title, image);
              },
            ),
            InkWell(
              child: Image.asset(
                "assets/imgs/twitter.png",
                width: 35,
                height: 35,
              ),
              onTap: () {
                share(context, title, image);
              },
            ),
          ],
        ),
      ),
    );
  }



  share(BuildContext context, String title, String image) {
    final RenderBox box = context.findRenderObject();

    Share.share(
        "$title . "
        ""
        "Advertis Image : $image",
        subject: title,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
