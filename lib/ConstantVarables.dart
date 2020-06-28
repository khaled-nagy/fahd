import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConstantVarable {
  static String apiUrl = "http://fahd.dgtech-sa.com/API/";
  static String apiImg = "https://www.q8pulse.app/public/";

  static String sectionId;
  static String subSectionId;
  static String cityId;
  static String userName;
  static String userId;
  static bool allAddsOrOne;
  static String lang;

  static final GlobalKey<FormState> regformKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> regScaffoldkey = GlobalKey<ScaffoldState>();

  static bool regAutoValid = false;

  static final GlobalKey<FormState> regProformKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> regProScaffoldkey = GlobalKey<ScaffoldState>();

  static bool regProAutoValid = false;

  static final GlobalKey<FormState> loginformKey = GlobalKey<FormState>();
  static final GlobalKey<ScaffoldState> loginScaffoldkey =
      GlobalKey<ScaffoldState>();
  static bool loginAutoValid = false;

  static final GlobalKey<FormState> addAddsFormKey = GlobalKey<FormState>();
  static final GlobalKey<ScaffoldState> addAddsScaffoldkey =
      GlobalKey<ScaffoldState>();
  static bool addAddsAutoValid = false;

  static final GlobalKey<FormState> sendMessageFormKey = GlobalKey<FormState>();
  static final GlobalKey<ScaffoldState> sendMessageScaffoldkey =
      GlobalKey<ScaffoldState>();
  static bool sendMessageAutoValid = false;

  static final GlobalKey<FormState> registerPhoneFormKey =
      GlobalKey<FormState>();
  static final GlobalKey<ScaffoldState> registerPhoneScaffoldkey =
      GlobalKey<ScaffoldState>();
  static bool registerPhoneAutoValid = false;

  static final GlobalKey<FormState> socialFormKey = GlobalKey<FormState>();
  static final GlobalKey<ScaffoldState> socialScaffoldkey =
      GlobalKey<ScaffoldState>();
  static bool socialAutoValid = false;

  static final TextEditingController phoneController = TextEditingController();
  static final TextEditingController emailController = TextEditingController();

  static final TextEditingController passwordController =
      TextEditingController();

  static final TextEditingController confirmPasswordController =
      TextEditingController();

  static final TextEditingController userNameController =
      TextEditingController();

  static final TextEditingController lastNameController =
      TextEditingController();
  static final TextEditingController oldPassController =
      TextEditingController();
  static final TextEditingController nameArController = TextEditingController();
  static final TextEditingController nameEnController = TextEditingController();
  static final TextEditingController describeArController =
      TextEditingController();
  static final TextEditingController describeEnController =
      TextEditingController();

  static final TextEditingController messageController =
      TextEditingController();
}
