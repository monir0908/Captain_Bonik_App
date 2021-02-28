import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin App {
  // Fields are provided
  _AppColor get color => _AppColor.appColor;
  _AppStyle get style => _AppStyle.appStyle;
  _AppAssets get asset => _AppAssets.appAssets;
  _AppSize get size => _AppSize.appSize;
  MediaQueryData get screen => App._screen;
  BuildContext get contextApp => App._contextApp;

  // Static field and initialization
  static MediaQueryData _screen;
  static BuildContext _contextApp;
  _AppSettings get settings => _AppSettings.appSettings;
  static _AppSettings get setting => _AppSettings._appSettings;
  static void initApp(BuildContext context) {
    _screen = MediaQuery.of(context);
    _contextApp = context;
  }
  //
  // //Server Token
  // static HomePageDataResponse _pageData;
  // static HomePageDataResponse get pageData => _pageData;
  // static int _userId;
  // static int get userId => _userId;


  static bool _isFromBangladesh = false;
  static bool get isFromBangladesh => _isFromBangladesh;
  static setIsUserFromBangladesh(bool value){
    _isFromBangladesh = value;
  }

  //App Language
  static AppLanguage _appLanguage = AppLanguage.english;
  static AppLanguage get currentAppLanguage => _appLanguage;
  static Language _appLabel = _EnglishLanguage.instance;
  Language get lbl => _appLabel;
}

// Defined classes
class _AppColor {
  _AppColor._();
  static _AppColor _appColor;
  static _AppColor get appColor => _appColor ?? (_appColor = _AppColor._());

  // // colors
  // Color get headerTextColorBlack => Color(0xff6A6A6A);
  // Color get onBoardingContentTextColor => Color(0xFF8257FD);
  //
  get primaryWhite => Colors.white;
  // get primaryRed => Color(0xffCE59FF); //Color(0xFFF96363);
  // get primaryGradient =>
  //     LinearGradient(colors: [Color(0xffda53FF), Color(0xff5F91FF)]);
  // get primaryBlue => Color(0xff0074BC);
  // LinearGradient get redGradient =>
  //     LinearGradient(colors: [Color(0xffFC5C82), Color(0xffFFAFB4)]);
  // LinearGradient get skyGradient =>
  //     LinearGradient(colors: [Color(0xff23A6F4), Color(0xff9FF3E9)]);
  // LinearGradient get purpleGradient =>
  //     LinearGradient(colors: [Color(0xff817FFE), Color(0xffF6C4FE)]);
  // LinearGradient get orangeGradient =>
  //     LinearGradient(colors: [Color(0xffFE9D55), Color(0xffFBEA95)]);
  //
  // LinearGradient get blueGradient =>
  //     LinearGradient(colors: [Color(0xffA3D6F0), Color(0xff0074BC)]);
  //
  // LinearGradient get transParentGradient =>
  //     LinearGradient(colors: [Colors.white, Colors.white]);
  // LinearGradient get grayGradient =>
  //     LinearGradient(colors: [Colors.grey[400], Colors.grey[400]]);
  // LinearGradient get onlyBlueGradient =>
  //     LinearGradient(colors: [Color(0xff0074BC), Color(0xff0074BC)]);
  //
  // LinearGradient get deepBlueGradient =>
  //     LinearGradient(colors: [Color(0xff2E3192), Color(0xff2E3192)]);
  //
  // LinearGradient get bleLightblueGradient => LinearGradient(
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  //   colors: <Color>[
  //     Color(0xFF2D3192),
  //     Color(0xff45AEFF),
  //   ],
  // );


}
class _AppSettings {
  _AppSettings._();
  static _AppSettings _appSettings;
  static _AppSettings get appSettings =>
      _appSettings ?? (_appSettings = _AppSettings._());

  Future<void> reset() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }


  // Future<HomePageDataResponse> getLocalData() async {
  //   Completer<HomePageDataResponse> _completer = Completer();
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     var x = prefs.getString("homePageData");
  //     if (x != null) {
  //       Map data = jsonDecode(x);
  //       var obj = HomePageDataResponse.fromJson(data);
  //       App.setToken(obj.user.token);
  //       App._userId = obj.user.id;
  //       App._pageData = obj;
  //       _completer.complete(obj);
  //     } else {
  //       _completer.completeError("Error to parse user data");
  //     }
  //   } catch (e) {
  //     print(e);
  //     _completer.completeError("Error to parse user data");
  //   }
  //
  //   return _completer.future;
  // }

  // Future<HomePageDataResponse> setLocalData(HomePageDataResponse data) async {
  //   Completer<HomePageDataResponse> _completer = Completer();
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     var srtData = HomePageDataResponse.fromJson(data.toJson());
  //     var value = jsonEncode(srtData);
  //     prefs.setString("homePageData", value).then((x) {
  //       App.setToken(data.user.token);
  //       App._userId = data.user.id;
  //       App._pageData = data;
  //       return _completer.complete(data);
  //     }).catchError((x) {
  //       _completer.completeError("Not stored !");
  //     });
  //   } catch (e) {
  //     print(e);
  //     _completer.completeError("Not stored !");
  //   }
  //
  //   return _completer.future;
  // }
  //
  // Future<bool> clearLocalHomePageData() async {
  //   Completer<bool> _completer = Completer();
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //     prefs.remove("calculatorData");
  //     prefs.remove("homePageData").then((x) {
  //       App._userId = null;
  //       App._pageData = null;
  //       return _completer.complete(true);
  //     }).catchError((x) {
  //       _completer.completeError("Not storred !");
  //     });
  //   } catch (e) {
  //     print(e);
  //     _completer.completeError("Not storred !");
  //   }
  //
  //   return _completer.future;
  // }


  //App Language
  Future<AppLanguage> getCurrentLanguage()async{
    Completer<AppLanguage> _completer = Completer();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int index = prefs.getInt("appLanguage");
      AppLanguage language = index == 1 ? AppLanguage.bangla: AppLanguage.english;
      App._appLabel = index == 1 ? _BanglaLanguage.instance:_EnglishLanguage.instance;
      App._appLanguage = language;
      _completer.complete(language);
    } catch (e) {
      //print(e);
      _completer.complete(AppLanguage.english);
    }
    return _completer.future;
  }
  Future<bool> setAppLanguage(int index) async {
    Completer<bool> _completer = Completer();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("appLanguage", index).then((x) {
        App._appLanguage = index == 0? AppLanguage.english:AppLanguage.bangla;
        App._appLabel = index == 0? _EnglishLanguage.instance:_BanglaLanguage.instance;

        AppEvents.instance._invokeAppLanguageChanged();
        _completer.complete(true);
        AppEvents.onLanguageChange();
      }).catchError((x) {
        _completer.completeError("Not storred !");
      });
    } catch (e) {
      print(e);
      _completer.completeError("Not storred !");
    }
    return _completer.future;
  }
}
class _AppAssets {
  _AppAssets._();
  static _AppAssets _appAssets;
  static _AppAssets get appAssets =>
      _appAssets ?? (_appAssets = _AppAssets._());

  String get logoCaptainBanik => 'assets/icons/common/logo.png';



}
class _AppSize {
  _AppSize._();
  static _AppSize _appSize;
  static _AppSize get appSize => _appSize ?? (_appSize = _AppSize._());

  double get screeHeightWithoutPadding =>
      (App._screen.size.height - App._screen.padding.top);

  double get fontFactor => 1;
}
class _AppStyle {
  _AppStyle._();
  static _AppStyle _appStyle;
  static _AppStyle get appStyle => _appStyle ?? (_appStyle = _AppStyle._());
  get buttonColorGradient => LinearGradient(colors: [
    Color(0xFF5781D0),
    Color(0xff025B98)
  ]); //LinearGradient(colors: [Color(0xffda53FF), Color(0xff5F91FF)]);  //[Color(0xfff053FF), Color(0xff5F91FF)]
  get textColorGradient =>
      LinearGradient(colors: [Color(0xff006A4E), Color(0xff006A4E)]);

  get textColorGradientForChapterPage => LinearGradient(colors: [
    Color(0xffFC7F21),
    Color(0xffFEBA55)
  ]); //[Color(0xfff053FF), Color(0xff5F91FF)]

//  TextStyle defaultTextStyle({double fontSize = 16}) => TextStyle(
//        color: _color.h,
//        fontSize: fontSize,
//        fontWeight: FontWeight.w400,
//      );
}


class AppEvents {
  AppEvents._();
  static AppEvents _appEvents;
  static AppEvents get instance => _appEvents ?? (_appEvents = AppEvents._());


  //App Language changed
  VoidCallback _appLanguageChangeEventCallback;
  void setOnLanguageChangedEventHandler(VoidCallback event){
    _appLanguageChangeEventCallback = event;
  }
  void _invokeAppLanguageChanged(){
    _appLanguageChangeEventCallback?.call();
  }


  StreamController _languageChangeStreamController = StreamController.broadcast();
  Stream get languageChangeEvent => _languageChangeStreamController.stream;
  static onLanguageChange(){
    if(!AppEvents.instance._languageChangeStreamController.isClosed){
      AppEvents.instance._languageChangeStreamController.sink.add(true);
    }
  }


  StreamController<int> _navigateToTabStreamController = StreamController.broadcast();
  Stream<int> get tabChangeEvent => _navigateToTabStreamController.stream;
  static navigateToTab(int tabIndex){
    if(!AppEvents.instance._navigateToTabStreamController.isClosed){
      AppEvents.instance._navigateToTabStreamController.sink.add(tabIndex);
    }
  }


  dispose(){
    _languageChangeStreamController?.close();
    _navigateToTabStreamController?.close();
  }
}
enum AppLanguage{
  english,
  bangla,
}

//************************** LANGUAGE INTERFACE ****************************
abstract class Language{
  String get signUpHeader;
  String get nameTitle;
  String get phoneTitle;
  String get emailTitle;
  String get nameHint;
  String get phoneHint;
  String get emailHint;
  String get continueText;
  String get signInHeader;
  String get otpVerification;
  String get otpDescription;
  String get resendOTP;
  String get otpVerifyOTP;

}
//************************** ENGLISH LANGUAGE ******************************
class _EnglishLanguage implements Language{
  _EnglishLanguage._();
  static Language _instance;
  static Language get instance => _instance ?? (_instance = _EnglishLanguage._());

  String get signUpHeader=>'Create account';
  String get nameTitle=>'Name';
  String get phoneTitle=>'Mobile number';
  String get emailTitle=>'Email (optional)';
  String get nameHint=>'Enter your full name';
  String get phoneHint=>'Enter your mobile number';
  String get emailHint=>'Enter your email';
  String get continueText=>'Continue';
  String get signInHeader=>'Log in';
  String get otpVerification => "Verification";
  String get otpDescription => "You will receive a 4 digit OTP shortly. Type your OTP code here and tap on \"Verify OTP\" button.";
  String get resendOTP => "Resend OTP";
  String get otpVerifyOTP => "Verify OTP";

}
//************************** BANGLA LANGUAGE *******************************
class _BanglaLanguage  implements Language{
  _BanglaLanguage._();
  static Language _instance;
  static Language get instance => _instance ?? (_instance = _BanglaLanguage._());
  String get signUpHeader=>'একাউন্ট তৈরি করুন';
  String get nameTitle=>'নাম';
  String get phoneTitle=>'মোবাইল নাম্বার';
  String get emailTitle=>'ইমেইল (ঐচ্ছিক)';
  String get nameHint=>'আপনার পুরো নামটি লিখুন';
  String get phoneHint=>'আপনার মোবাইল নাম্বার দিন';
  String get emailHint=>'আপনার ইমেইল লিখুন';
  String get continueText=>'চালিয়ে যান';
  String get signInHeader=>'লগ ইন';
  String get otpVerification => "ভেরিফিকেশন";
  String get otpDescription => "আপনি শীঘ্রই একটি ৪ ডিজিটের ওটিপি পাবেন। আপনার ওটিপি কোডটি এখানে টাইপ করুন এবং \"ভেরিফাই ওটিপি \" বোতামে  চাপুন।";
  String get resendOTP => "পুনরায় ও-টি-পি পাঠান";
  String get otpVerifyOTP => "ভেরিফাই ওটিপি";

}
