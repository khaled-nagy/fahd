import 'package:easy_localization/easy_localization.dart';
import 'package:elfhad/ConstantVarables.dart';
import 'package:elfhad/src/screens/splash_screen.dart';
import 'package:elfhad/src/servicess/PushNotificationService.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PushNotificationService().initialise();
  runApp(EasyLocalization(
      child: MyApp(),
      supportedLocales: [Locale('en'), Locale('ar')],
      path: "assets/langs",
      startLocale: Locale('ar'),
      //  fallbackLocale: Locale('ar'),
      saveLocale: true,
      // useOnlyLangCode: true,
      // optional assetLoader default used is RootBundleAssetLoader which uses flutter's assetloader
      // assetLoader: RootBundleAssetLoader()
      // assetLoader: NetworkAssetLoader()
      // assetLoader: TestsAssetLoader()
      // assetLoader: FileAssetLoader()
      // assetLoader: StringAssetLoader()
      // preloaderColor: Colors.red,
    )
);}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    ConstantVarable.lang = EasyLocalization.of(context).locale.toString() ;
    print("lang is ${ConstantVarable.lang}");
    return MaterialApp(
      title: 'Elfahd',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        EasyLocalization.of(context).delegate
      ],
      supportedLocales: EasyLocalization.of(context).supportedLocales,
      locale: EasyLocalization.of(context).locale,
      theme: ThemeData(
        textTheme: TextTheme(
          headline: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Color(0xFFC2A661),fontFamily: 'Tajawal'),
          display1: TextStyle(fontSize: 16.0, color: Colors.white,fontFamily: 'Tajawal'),
          display2: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Color(0xFF44444f),fontFamily: 'Tajawal'),
          display3: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2b9cb5),fontFamily: 'Tajawal'),
          display4: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white,fontFamily: 'Tajawal'),
          subhead: TextStyle(fontSize: 15.0, color: Color(0xff74747c),fontFamily: 'Tajawal'),
          title: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Color(0xFF59432A),fontFamily: 'Tajawal'),
          body1: TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.w500, color: Colors.black,fontFamily: 'Tajawal'),
          body2: TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.w500, color: Colors.white,fontFamily: 'Tajawal'),
          caption: TextStyle(fontSize: 12.0, color: Colors.grey[400],fontFamily: 'Tajawal'),
        ),

        primarySwatch: Colors.blue,
        accentColor: Color(0xFFC2A661),
        focusColor: Color(0xFF8C98A8),
        hintColor: Color(0xFF44444f),
        scaffoldBackgroundColor: Colors.black,
        // canvasColor: Colors.white.withOpacity(0.0),

        fontFamily: 'Tajawal',
      ),
      home: SplashScreen(),
      
    );
  }
}
