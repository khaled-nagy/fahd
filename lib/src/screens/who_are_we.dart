
import 'package:elfhad/src/widgets/AppBarWidget.dart';
import 'package:elfhad/src/widgets/SharedWidget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:elfhad/src/controllers/InformationController.dart';
import 'package:easy_localization/easy_localization.dart';



class WhoAreWeScreen extends StatefulWidget {
  createState() => WhoAreWeView();
}

class WhoAreWeView extends StateMVC<WhoAreWeScreen> {
  WhoAreWeView() : super(InformationController()) {
    _informationController = InformationController.con;
  }

  InformationController _informationController;
  bool isloading = false;

  @override
  void initState() {
   _informationController.getAboutUs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //endDrawer: DrawerW().showDrawerUser(context),
      appBar: AppBarWidget()
          .showAppBar(context, "_who_are_we".tr(), Container(), false),
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
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.height / 5,
                ),
              ),
              StreamBuilder(
                  stream: _informationController.getAboutUsStream.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.data['Title'],
                              style: Theme.of(context).textTheme.display1,
                            ),
                          ),
                          Text(
                            snapshot.data['Desc'],
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ],
                      );
                    } else {
                      return SharedWidget.loading(context);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }


}
