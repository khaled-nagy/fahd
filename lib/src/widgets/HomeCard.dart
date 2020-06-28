import 'package:elfhad/src/screens/category_screen.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatefulWidget {
  final int index;
  final Map<String, dynamic> data;
  HomeCard({this.index, this.data});
  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: widget.data['Image'] == null
                          ? AssetImage("assets/imgs/Group_35.png")
                          : NetworkImage(widget.data['Image']),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                height: 40,
                width: 10,
                decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: Colors.white),
                      top: BorderSide(color: Colors.grey[600])),
                    color: Theme.of(context).accentColor.withOpacity(0.5)),
              ),
              Expanded(
                child: Container(
                  height: 40,
                  decoration:
                      BoxDecoration(
                        color: Theme.of(context).accentColor,
                          border: Border(
                      
                      top: BorderSide(color: Colors.grey[600])),),
                      child: Center(
                        child: Text(
                    widget.data['Name'] == null ? "" : widget.data['Name'],
                    style: Theme.of(context).textTheme.title,
                  ),
                      ),
                ),
              ),
            ],
          )
        ],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryScreen(
                      title: widget.data['Name'] == null
                          ? ""
                          : widget.data['Name'],
                          categoryId: widget.data['id'],
                    )));
      },
    );
  }
}
