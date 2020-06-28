
import 'package:elfhad/src/controllers/AddsController.dart';
import 'package:elfhad/src/controllers/UserLocalStorage.dart';
import 'package:elfhad/src/widgets/AppBarWidget.dart';
import 'package:elfhad/src/widgets/CategoryCard.dart';
import 'package:elfhad/src/widgets/SharedWidget.dart';
import 'package:elfhad/src/widgets/drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class UserAddsScreen extends StatefulWidget {
   String title;
  UserAddsScreen({this.title });
  createState() => UserAddsView();
}

class UserAddsView extends StateMVC<UserAddsScreen> {
  UserAddsView() : super(AddsController()) {
    addsController = AddsController.con;
  }

  AddsController addsController;




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
    UserLocalStorage().getUser().then((user) {
addsController.getUserAdds(user.id);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyHome,
      appBar: AppBarWidget().showAppBar(context, widget.title, menu() , false),
      drawer: DrawerW().showDrawer(context, _scaffoldKeyHome),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
             Container(
              height: 16,
            ),
       
         
            
           
              StreamBuilder(
                stream: addsController.getUserAddsStream.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return subSectionsList(snapshot.data);
                  } else {

                   print(snapshot.data == null);
                   if(snapshot.data == null){
                     return Padding(
                       padding: const EdgeInsets.only(top: 100),
                       child: Center(
                         child: Text("No Data Fonded" , style: Theme.of(context).textTheme.display4,),
                       ),
                     );
                   }else{
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
    return    ListView.builder(
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

    Widget imageProfile() {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Color(0xffBF1162),
            radius: MediaQuery.of(context).size.width/15,
            child: addsController.imageAdd == null
                ? CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/imgs/person_avatar.jpg"),
                    radius: MediaQuery.of(context).size.width/15,
                  )
                : addsController.imageAdd != null
                    ? CircleAvatar(
                        backgroundImage:
                            FileImage(addsController.imageAdd),
                        radius: 50,
                      )
                    : Card(
                        shape: CircleBorder(),
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            child: Image.asset(
                              'assets/imgs/ic_upload_avatar.png',
                              height: 300,
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
