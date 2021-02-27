import 'package:flutter/material.dart';

class LanguageChangeSwitch extends StatefulWidget {
  final ValueChanged onChanged;

  const LanguageChangeSwitch({Key key, this.onChanged}) : super(key: key);
  @override
  _LanguageChangeSwitchState createState() => _LanguageChangeSwitchState();
}

const double width = 132.0;
const double height = 38.0;
const double loginAlign = -1;
const double signInAlign = 1;
const Color selectedColor = Color(0xff006A4E);
const Color normalColor = Colors.white;

class _LanguageChangeSwitchState extends State<LanguageChangeSwitch> {
  double xAlign;
  Color loginColor;
  Color signInColor;

  @override
  void initState() {
    super.initState();
    xAlign = loginAlign;
    loginColor = selectedColor;
    signInColor = normalColor;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Color(0xff006A4E),
          border: Border.all(color: Colors.white.withOpacity(.5),width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: Alignment(xAlign, 0),
              duration: Duration(milliseconds: 300),
              child: Container(
                width: width * 0.5,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(13.0),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  xAlign = loginAlign;
                  loginColor = selectedColor;
                  signInColor = normalColor;
                  widget.onChanged('en');
                });
              },
              child: Align(
                alignment: Alignment(-1, 0),
                child: Container(
                  width: width * 0.5,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    'EN',
                    style: TextStyle(
                      color: loginColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  xAlign = signInAlign;
                  signInColor = selectedColor;
                  loginColor = normalColor;
                  widget.onChanged('ban');
                });
              },
              child: Align(
                alignment: Alignment(1, 0),
                child: Container(
                  width: width * 0.5,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    'BAN',
                    style: TextStyle(
                      color: signInColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}