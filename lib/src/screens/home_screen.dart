import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:elfhad/src/controllers/HomeController.dart';
import 'package:elfhad/src/widgets/AppBarWidget.dart';
import 'package:elfhad/src/widgets/HomeCard.dart';
import 'package:elfhad/src/widgets/SharedWidget.dart';
import 'package:elfhad/src/widgets/drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:connectivity/connectivity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  createState() => HomeView();
}

class HomeView extends StateMVC<HomeScreen> {
  HomeView() : super(HomeController()) {
    homeController = HomeController.con;
  }

  HomeController homeController;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    homeController.getAllSections();
    super.initState();
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false);
    _refreshController.refreshCompleted();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        String wifiName, wifiBSSID, wifiIP;

        try {
          if (Platform.isIOS) {
            LocationAuthorizationStatus status =
                await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
                  await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiName = await _connectivity.getWifiName();
            } else {
              wifiName = await _connectivity.getWifiName();
            }
          } else {
            wifiName = await _connectivity.getWifiName();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiName = "Failed to get Wifi Name";
        }

        try {
          if (Platform.isIOS) {
            LocationAuthorizationStatus status =
                await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
                  await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiBSSID = await _connectivity.getWifiBSSID();
            } else {
              wifiBSSID = await _connectivity.getWifiBSSID();
            }
          } else {
            wifiBSSID = await _connectivity.getWifiBSSID();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiBSSID = "Failed to get Wifi BSSID";
        }

        try {
          wifiIP = await _connectivity.getWifiIP();
        } on PlatformException catch (e) {
          print(e.toString());
          wifiIP = "Failed to get Wifi IP";
        }

        setState(() {
          _connectionStatus = '$result\n'
              'Wifi Name: $wifiName\n'
              'Wifi BSSID: $wifiBSSID\n'
              'Wifi IP: $wifiIP\n';
        });
        break;
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('_close_app'.tr()),
                content: Text('_are_you_sure_to_close_app'.tr()),
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
                              EasyLocalization.of(context).locale ==
                                      Locale('en')
                                  ? "cancel"
                                  : "الغاء",
                              style: TextStyle(
                                  color: Colors.grey[50],
                                  fontSize:
                                      MediaQuery.of(context).size.width / 23),
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(false);
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
                              EasyLocalization.of(context).locale ==
                                      Locale('en')
                                  ? "ok"
                                  : "حسنا",
                              style: TextStyle(
                                  color: Colors.grey[50],
                                  fontSize:
                                      MediaQuery.of(context).size.width / 23),
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      exit(0);
                    },
                  )
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        key: _scaffoldKeyHome,
        appBar: AppBarWidget().showAppBar(context, "_home".tr(), menu(), true),
        drawer: DrawerW().showDrawer(context, _scaffoldKeyHome),
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 20,
                ),
                StreamBuilder(
                    stream: homeController.getAllSectionsStream.stream,
                    builder: (context, snapshot) {
                      if (_connectionStatus == "Unknown") {
                        print(_connectionStatus);
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 200),
                              child: Center(
                                  child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '_no_internet'.tr(),
                                      style:
                                          Theme.of(context).textTheme.display1,
                                    ),
                                  ),
                                  Text(
                                    '_reload_page'.tr(),
                                    style: Theme.of(context).textTheme.display1,
                                  ),
                                ],
                              )),
                            ),
                          ],
                        );
                      } else {
                        if (snapshot.hasData) {
                          return gridSections(snapshot.data);
                        } else {
                          return Center(
                            child: SharedWidget.loading(context),
                          );
                        }
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget gridSections(List data) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 24, crossAxisSpacing: 8),
        physics: ClampingScrollPhysics(),
        itemCount: data.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return HomeCard(
            index: index,
            data: data[index],
          );
        });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
