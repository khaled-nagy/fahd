import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarWidget {
  Widget showAppBar(BuildContext context, String title, Widget widget , bool home,
      {int position}) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline,
      ),
      centerTitle: true,
      backgroundColor: Color(0xff2D2926),
      leading: widget
      // IconButton(
      //   icon: Icon(
      //     Icons.arrow_back,
      //     color: Colors.grey[800],
      //   ),
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      // )
      ,
      actions: <Widget>[

        home == true ? IconButton(
          icon:
           Icon
           (Icons.close ,
            color: Theme.of(context).accentColor,),
             onPressed: (){
               SystemNavigator.pop();
             })  :
        IconButton(
            icon: Icon(
              Icons.arrow_forward,
              size: 30,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            })
      ],
      elevation: 0,
    );
  }
}
