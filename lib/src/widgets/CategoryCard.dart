import 'package:elfhad/src/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final int index ;
  final   String title ;
  final Map<String , dynamic> data ;
  CategoryCard({this.index , this.title , this.data});
  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {


  @override
  Widget build(BuildContext context) {
    
    bool zero = false ;

    if(widget.index%(2)==0){
      zero = true ;
    }else{
      zero = false ;
    }

    return InkWell(
          child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height:zero == true ?
           MediaQuery.of(context).size.height/9 :
           MediaQuery.of(context).size.height/7
           ,
          decoration: BoxDecoration(
            color: zero == true ? 
             Theme.of(context).accentColor :
             Theme.of(context).accentColor.withOpacity(0.0)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    Spacer(),
      Row(
        children: <Widget>[
          Text(widget.data['Name'] == null ?
          "":
          widget.data['Name']  , 
          style: zero == true ?
           Theme.of(context).textTheme.title:
           Theme.of(context).textTheme.display4
           ),
        ],
      ),
      Spacer(),
      Container(
        width: MediaQuery.of(context).size.width/1.7,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

              Container(
              child: Row(
                children: <Widget>[
                  Image.asset("assets/imgs/location.png" , width: 10,height: 10,),
                  Container(width: 2,),
                  Text(widget.data['City'] == null ?
      "":
      widget.data['City']  , style: zero == true ?
                   Theme.of(context).textTheme.body1:
                   Theme.of(context).textTheme.body2)
                ],
              ),
            ),

            Container(
              child: Row(
                children: <Widget>[
                  Image.asset("assets/imgs/time.png" , width: 10,height: 10,),
                  Container(width: 2,),
                  Text(widget.data['AcceptedAtTime'] == null ?
      "":
      widget.data['AcceptedAtTime']  , style: zero == true ?
                   Theme.of(context).textTheme.body1:
                   Theme.of(context).textTheme.body2)
                ],
              ),
            ),
             Container(
              child: Row(
                children: <Widget>[
                  Image.asset("assets/imgs/profile.png" , width: 10,height: 10,),
                  Container(width: 2,),
                  Text(widget.data['user'] == null ?
      "":
      widget.data['user'] , style: zero == true ?
                   Theme.of(context).textTheme.body1:
                   Theme.of(context).textTheme.body2)
                ],
              ),
            ),
           
            
          ],
        ),
      ),
      Spacer(),
  ],
),

Container(
  width: 100,
  height: 70,
  decoration: BoxDecoration(
      image: DecorationImage(image: 
      widget.data['Image'] == null ?
      AssetImage("assets/imgs/car.jpg"):
      NetworkImage(widget.data['Image']),fit: BoxFit.cover),
      borderRadius: BorderRadius.circular(12)
  ),
)
            ],
          ),
          
        ),
      ),
      onTap: (){
        Navigator.push(context, 
        MaterialPageRoute(builder: (context) => ProdeuctDetailsScreen(
          title: widget.title == null ? "" : widget.title,
          subCategoryId: widget.data['id']

        )));
      },
    );
  }
}