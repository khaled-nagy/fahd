import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:elfhad/src/data/models/AreaMenu.dart';
import 'package:elfhad/src/data/models/CityMenu.dart';
import 'package:elfhad/src/screens/home_screen.dart';
import 'package:elfhad/src/screens/user_adds_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:elfhad/ConstantVarables.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;

// import '../Data/Models/Locatuion.dart';

class AddsController extends ControllerMVC {
  //to make single instance of class
  factory AddsController() {
    if (_this == null) _this = AddsController._();
    return _this;
  }
  static AddsController _this;

  AddsController._();
  File imageAdd;

  static AddsController get con => _this;
  static final url = ConstantVarable.apiUrl;

 

  final getUserAddsStream = StreamController.broadcast();
  void getUserAdds(String userId) async {
    await http
        .get(
      "${url}GetAllAdsUser.php?userid=$userId&Lang=${ConstantVarable.lang}",
    )
        .then((response) {
      if (response.statusCode == 200) {
        var jsonValu = jsonDecode(response.body);
        print(" GetAllAdsUser Response is ::::::::: " + jsonValu.toString());
        getUserAddsStream.sink.add(jsonValu['Ads']);
      }
    }, onError: (error) {
      // getUserAddsStream.close();
      print("GetAllAdsUser Response is :::: $error");
    });
  }



  Future<String> addAdvertis(
      BuildContext context,
      String subSectionId,
      String nameAr,
      String nameEn,
      String describeAr,
      String describeEn,
      String usid,
      String city,
      File img
) async {
    Dio dio = Dio();

    FormData formData = FormData.fromMap( {
      "IDSubSections": subSectionId,
      "NameAr": nameAr,
      "NameEn": nameEn,
      "DescribeAr": describeAr,
      "DescribeEn": describeEn,
      "usid": usid,
      "City": city,
      "img": await MultipartFile.fromFile(
        imageAdd.path ,
         filename: basename(img.path) ,
          // contentType: MediaType('img' , 'png' , 'jpg' )
          )
    });

   String realUrl = "${url}NewAds.php";

  return  await dio.post(realUrl , data: formData , options: Options(
    headers: {"Content-Type": "multipart/form-data"}
  )).then((response) {


    
      if (response.statusCode == 200) {

           print(response.statusCode.toString());
           print(formData.fields);
 print(formData.files);
  print(realUrl);

            return response.data;
      } else {

        
        return "";
      }
    });
  }

  Future<bool> addAdvertiseLogic(
     BuildContext context,
      String subSectionId,
      String nameAr,
      String nameEn,
      String describeAr,
      String describeEn,
      String usid,
      String city,
      File img
      ) async {

            final form = ConstantVarable.addAddsFormKey.currentState;
    ConstantVarable.addAddsAutoValid = true;

if(form.validate()){
  form.save();
   return   addAdvertis(
      context,
       subSectionId, 
       nameAr, 
       nameEn,
        describeAr,
         describeEn,
          usid, 
          city, 
          img).then((advertiseModel) {

            if(advertiseModel != "" ){
              form.reset();
              print("message is :: " +advertiseModel.toString());
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => UserAddsScreen()));
            return true ;
            }else{

              print("message is :: " +advertiseModel.toString());

              return false ;

            }
          

          });
         

}

 return false ;


  
  }

  Future getImageAdd() async {
    var imagex = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageAdd = imagex;
    });
    refresh();

    imageAdd.exists().then((yas) {
      print(yas);
      if (yas) {
        //  updateImage();
      }
    });
  }


  Future<List<CityMenu>> getAllCity ( ) async {
      
      return await http.get(
      "${url}GetAllCity.php?Lang=${ConstantVarable.lang}",
     
    ).then((response) {
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);
        print("cities is :::: ${jsonValue['Cities']}");
        return (jsonValue['Cities'] as List)
            .map((f) => new CityMenu.fromJson(f))
            .toList();
      } else
        return List<CityMenu>();
    },onError: (err){
      print("cities error is :::: $err");
    });

  }

   List<CityMenu> cities = List<CityMenu>();

   Future getAllCities() async {


    refresh();
    cities = await getAllCity();
    
    refresh();
   }
  final getAreaStream = StreamController.broadcast();
  Future<List<AreaMenu>> getAllArea (String cityId ) async {

    return await http.get(
      "${url}GetSubCity.php?Lang=${ConstantVarable.lang}&CityID=$cityId",

    ).then((response) {
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);
        print("Regions is :::: ${jsonValue['SubCity']}");
        getAreaStream.sink.add(jsonValue);
        return (jsonValue['SubCity'] as List)
            .map((f) => new AreaMenu.fromJson(f))
            .toList();
      } else
        return List<AreaMenu>();
    },onError: (err){
      getAreaStream.close();
      print("Regions error is :::: $err");
    });

  }

  List<AreaMenu> regions = List<AreaMenu>();

  Future getAllRegions(String cityId) async {


    refresh();
    regions = await getAllArea(cityId);

    refresh();
  }



}
