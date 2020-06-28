

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {

 final FirebaseMessaging _fcm = FirebaseMessaging();

 Future initialise() async{

   String token ;

if(Platform.isIOS){
  _fcm.requestNotificationPermissions(IosNotificationSettings());
  token = await _fcm.getToken();
  print("plat form is :  ");
print("toke is : $token ");
}

token = await _fcm.getToken();
print("plat form is : ");
print("toke is : $token ");

_fcm.configure(
  onMessage: (Map<String , dynamic> message)async{
     print("onMessage: $message");
  },
  onLaunch: (Map<String , dynamic> message)async{
     print("onLaunch: $message");
  },
  onResume: (Map<String , dynamic> message)async{
     print("onResume: $message");
  }
);

 }
   void _serialiseAndNavigate(Map<String, dynamic> message) {
    var notificationData = message['data'];
    var view = notificationData['view'];

    if (view != null) {
      // Navigate to the create post view
      if (view == 'create_post') {
        // _navigationService.navigateTo(CreatePostViewRoute);
      }
    }
  }

}