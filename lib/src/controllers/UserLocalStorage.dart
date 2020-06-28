import 'package:elfhad/src/data/models/SectionsModel.dart';
import 'package:elfhad/src/data/models/SubSectionModel.dart';
import 'package:elfhad/src/data/models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalStorage {
  Future<bool> saveClient(UserModel user) async {
    print("befor save   ${user.email}");
    print("********* FROM THE RESPONSE ********* save   ${user.name}");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("id", user.id);
      await prefs.setString("Name", user.name);
      await prefs.setString("Email", user.email);
      await prefs.setString("Address", user.address);
      await prefs.setString("Mobile", user.mobile);

      //await prefs.setString("imgPath", user.);
      print("saved data ${user.id}+${user.name} +${user.email}");
      return true;
    } catch (Excption) {
      print("save to shared faild   :  $Excption");
      return false;
    }
  }

  Future<UserModel> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return new UserModel(
        id: prefs.getString("id"),
        name: prefs.getString("Name"),
        email: prefs.getString("Email"),
        address: prefs.getString("Address"),
        mobile: prefs.getString("Mobile"));
  }


  ///////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////
  

    Future<bool> saveSubSctionsInfo(SubSectionsModel subSectionsModel) async {
    print("befor save   ${subSectionsModel.id}");
    print("********* FROM THE RESPONSE ********* save   ${subSectionsModel.name}");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("id", subSectionsModel.id);
      await prefs.setString("Name", subSectionsModel.name);

      //await prefs.setString("imgPath", user.);
      print("saved data ${subSectionsModel.id}+${subSectionsModel.name} ");
      return true;
    } catch (Excption) {
      print("save to shared faild   :  $Excption");
      return false;
    }
  }

    Future<SubSectionsModel> getSubSctionsInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return new SubSectionsModel(
        id: prefs.getString("id"),
        name: prefs.getString("Name"),
        );
  }


  ///////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////
  
      Future<bool> saveSctionsInfo(SubSectionsModel sectionsModel) async {
    print("befor save   ${sectionsModel.id}");
    print("********* FROM THE RESPONSE ********* save   ${sectionsModel.name}");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("id", sectionsModel.id);
      await prefs.setString("Name", sectionsModel.name);

      //await prefs.setString("imgPath", user.);
      print("saved data ${sectionsModel.id}+${sectionsModel.name} ");
      return true;
    } catch (Excption) {
      print("save to shared faild   :  $Excption");
      return false;
    }
  }

    Future<SectionsModel> getSctionsInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return new SectionsModel(
        id: prefs.getString("id"),
        name: prefs.getString("Name"),
        );
  }

  Future<bool> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return true;
  }
}
