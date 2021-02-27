import 'package:flutter/material.dart';
import 'app.dart';

String label({@required String e,@required String b}){
  return App.currentAppLanguage == AppLanguage.bangla? b??e:e;
}