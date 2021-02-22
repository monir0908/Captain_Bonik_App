import 'package:captain_bonik_app/common/pages/authentication_page.dart';
import 'package:captain_bonik_app/common/pages/user_land_page.dart';
import 'package:captain_bonik_app/common/widgets/rounded_corner.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startPage();
  }
  @override
  Widget build(BuildContext context) {
    return RoundedCorner(child:Container(
      child: Center(child: Text('Captain Banik\nSplash Screen',
      style: TextStyle(fontSize: 24,color: Colors.indigo),
      )),
    ));
  }
  void _startPage() {
    Future.delayed(Duration(seconds: 2)).then((x) async{
      Navigator.of(context)..pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthenticationPage()), ModalRoute.withName('/auth'));
    });
  }
}
