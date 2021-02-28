import 'package:captain_bonik_app/common/pages/authentication_page.dart';
import 'package:captain_bonik_app/common/utils/app.dart';
import 'package:captain_bonik_app/common/widgets/rounded_corner.dart';
import 'package:captain_bonik_app/modules/buyer/pages/buyer_landing_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with App{
  @override
  void initState() {
    super.initState();
    _startPage();
  }
  @override
  Widget build(BuildContext context) {
    App.initApp(context);
    return RoundedCorner(child:Container(
      child: Center(child: Text('Captain Banik\nSplash Screen',
      style: TextStyle(fontSize: 24,color: Colors.indigo),
      )),
    ));
  }
  void _startPage() {
    Future.delayed(Duration(seconds: 2)).then((x) async{
      Navigator.of(context)..pushAndRemoveUntil(MaterialPageRoute(builder: (context) => UserLandPage()), ModalRoute.withName('/auth'));
    });
  }
}
