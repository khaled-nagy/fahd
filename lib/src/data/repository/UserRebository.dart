

import 'package:elfhad/src/data/models/UserModel.dart';

abstract class UserRebository {
  Future<UserModel> signInWithEmailAndPassword(String email , String pass);
  Future<UserModel> regNewUser(String name , String pass , String email , String address , String mobile);
}
