import 'dart:convert';

import 'package:elfhad/ConstantVarables.dart';
import 'package:elfhad/src/data/models/UserModel.dart';

import 'package:elfhad/src/data/repository/UserRebository.dart';
import 'package:http/http.dart' as http;

class UserService extends UserRebository {
  @override
  Future<UserModel> signInWithEmailAndPassword(
      String email, String pass) async {
    return await http
        .get(
      ConstantVarable.apiUrl + "GetUser.php?Email=$email&password=$pass",
    )
        .then((response) {
      if (response.statusCode == 200) {
        var jsonValue = jsonDecode(response.body);

        print(jsonValue);
        return UserModel.fromJson(jsonValue);
      } else{
var jsonValue = jsonDecode(response.body);
return UserModel.fromJson(jsonValue);
      }
        
    });
  }

  @override
  Future<UserModel> regNewUser(
      String name, String pass, String email, String address , String mobile) async {

        String url =  ConstantVarable.apiUrl +
          "NewUser.php?Name=$name&password=$pass&Email=$email&Address=$address&Mobile=$mobile" ;
    return await http
        .get(url,
    )
        .then((response) {
      if (response.statusCode == 200) {
        print(url);
        var jsonValue = jsonDecode(response.body);
        return UserModel.fromJson(jsonValue);
        
      } else
        return UserModel();
    });
  }
}
