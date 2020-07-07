import 'dart:async';
import 'dart:convert';
import 'package:elfhad/ConstantVarables.dart';
import 'package:elfhad/src/data/models/SectionsModel.dart';
import 'package:elfhad/src/data/models/SubSectionModel.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

// import '../Data/Models/Locatuion.dart';

class CategoryController extends ControllerMVC {
  //to make single instance of class
  factory CategoryController() {
    if (_this == null) _this = CategoryController._();
    return _this;
  }
  static CategoryController _this;

  CategoryController._();

  static CategoryController get con => _this;
  static final url = ConstantVarable.apiUrl;

  Map<String, dynamic> dataDetails = Map<String, dynamic>();

  final getSubSectionsStream = StreamController.broadcast();
  void getSubSections(String sectionId) async {
    await http
        .get(
      "${url}GetAllAds.php?Lang=${ConstantVarable.lang}&Spid=$sectionId",
    )
        .then((response) {
      if (response.statusCode == 200) {
        var jsonValu = jsonDecode(response.body);
        print(" SubSections Response is ::::::::: " + jsonValu.toString());
        getSubSectionsStream.sink.add(jsonValu['Ads']);

        // List<dynamic> subCategories = jsonValu['Ads'];
        // for (int i = 0; i < subCategories.length; i++) {
        //   subCategoryList.add(
        //     CategorySubMenu(jsonValu['Ads'][i]['id'], jsonValu['Ads'][i]['Name']),
        //   );
        // }
      }
    }, onError: (error) {
      getSubSectionsStream.close();
      print("SubSections Response is :::: $error");
    });
  }

  final getSubSectionsBySectionIdStream = StreamController.broadcast();
  void getSubSectionsBySectionId(String subSectionId, String cityId) async {
    await http
        .get(
      "${url}GetAllAdsSub.php?Lang=${ConstantVarable.lang}&Subid=$subSectionId&City=$cityId",
    )
        .then((response) {
      if (response.statusCode == 200) {
        var jsonValu = jsonDecode(response.body);
        print(
            " SubSections by id Response is ::::::::: " + jsonValu.toString());
        getSubSectionsBySectionIdStream.sink.add(jsonValu['Ads']);
      }
    }, onError: (error) {
      getSubSectionsBySectionIdStream.close();
      print("SubSections by id Response is :::: $error");
    });
  }

  final subCategoryDetailsStream = StreamController.broadcast();
  void getSubCategoryDetails(String sectionId) async {
    await http
        .get(
      "${url}GetAds.php?Lang=${ConstantVarable.lang}&Spid=$sectionId",
    )
        .then((response) {
      if (response.statusCode == 200) {
        var jsonValu = jsonDecode(response.body);
        print(" adds details Response is ::::::::: " + jsonValu.toString());
        subCategoryDetailsStream.sink.add(jsonValu['Ads']);

        dataDetails = jsonValu['Ads'][0];
      }
    }, onError: (error) {
      subCategoryDetailsStream.close();
      print("adds details Response is :::: $error");
    });
  }

  urlMaill(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Could not launch $url");
    }
  }

  final getAllSubSectionMenuStream = StreamController.broadcast();
  Future<List<SubSectionsModel>> getAllSubSectionMenu(String sectionId) async {

    String realUrl = "${url}GetSubSection.php?Spid=$sectionId&Lang=${ConstantVarable.lang}";
    return await http
        .get(
      realUrl,
    )
        .then((response) {
      if (response.statusCode == 200) {
        print("url is : $realUrl");
        var jsonValue = json.decode(response.body);
        print("SubSection is :::: ${jsonValue['SubSections']}");
        getAllSubSectionMenuStream.sink.add(jsonValue['SubSections']);
        return (jsonValue['SubSections'] as List)
            .map((f) => new SubSectionsModel.fromJson(f))
            .toList();
      } else
        return ([] as List)
            .map((f) => new SubSectionsModel.fromJson(f))
            .toList();
    }, onError: (err) {
      print("SubSection error is :::: $err");
      getAllSubSectionMenuStream.close();
    });
  }

  List<SubSectionsModel> subSectionList = List<SubSectionsModel>();

  Future getAllSubSectionMenuButton(String sectionId) async {
    refresh();

   await getAllSubSectionMenu(sectionId).then((menuList) {
     if(menuList == null){
       print("menu list is : $menuList");
       subSectionList = [SubSectionsModel(
         id: "0" ,
         name: "لا توجد اقسام فرعية"
       )];
     }else {
       subSectionList =  menuList;
       print("menu list is : ${menuList.toString()}");
     }
   });





    refresh();
  }

  Future<List<SectionsModel>> getAllSectionMenu() async {
    return await http
        .get(
      "${url}GetAllSections.php?Lang=${ConstantVarable.lang}",
    )
        .then((response) {
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);
        print("Section is :::: ${jsonValue['Sections']}");

        return (jsonValue['Sections'] as List)
            .map((f) => new SectionsModel.fromJson(f))
            .toList();
      } else
        return List<SectionsModel>();
    }, onError: (err) {
      print("SubSection error is :::: $err");
    });
  }

  List<SectionsModel> sectionList = List<SectionsModel>();

  Future getAllSectionMenuButton() async {
    refresh();
    sectionList = await getAllSectionMenu();

    refresh();
  }

  final getImageStream = StreamController.broadcast();
  void getImage(String type) async {
    await http
        .get(
      "${url}GetAdsType.php?Type=$type",
    )
        .then((response) {
      if (response.statusCode == 200) {
        var jsonValu = jsonDecode(response.body);
        print(" image  Response is ::::::::: " + jsonValu.toString());
        getImageStream.sink.add(jsonValu['Ads']);
      }
    }, onError: (error) {
      getImageStream.close();
      print("image Response is :::: $error");
    });
  }
}
