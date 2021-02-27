import 'package:captain_bonik_app/common/pages/sign_up_page.dart';
import 'package:captain_bonik_app/common/utils/app.dart';
import 'package:captain_bonik_app/common/widgets/language_change_switch.dart';
import 'package:captain_bonik_app/common/widgets/rounded_corner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> with App {

  @override
  Widget build(BuildContext context) {
    return RoundedCorner(
        child: Stack(
      children: [
        Container(
          color: Color(0xff006A4E),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screen.padding.top * 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  children: [
                    Image.asset(asset.logoCaptainBanik,
                      width: 52,
                    ),
                    Spacer(),
                    LanguageChangeSwitch(
                      onChanged: _languageHandler,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 16, bottom: 24),
                child: Text(
                  lbl.signUpHeader,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                  child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                child:SignUpPage(),
              ))
            ],
          ),
        )
      ],
    ));
  }

  _languageHandler(value) {
    // setState(() {
    if (value == 'ban') {
      settings.setAppLanguage(1).then((value) {
        setState(() {});
      });
    } else {
      settings.setAppLanguage(0).then((value) {
        setState(() {});
      });
    }
    // });
  }
}
