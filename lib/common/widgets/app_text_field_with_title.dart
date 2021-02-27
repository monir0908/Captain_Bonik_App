import 'package:captain_bonik_app/common/utils/app.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final bool autoMaxLine;

  const AppTextField({
    Key key,
    @required this.hintText,
    @required this.controller,
    this.focusNode,
    this.obscureText= false,
    this.keyboardType= TextInputType.text,
    this.autoMaxLine
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> with App{
  bool _hasFocused= false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _hasFocused = focusNode.hasFocus;
    focusNode.addListener((){
      _changeBorder();
    });
  }
  void _changeBorder() {
    setState(() {
      _hasFocused = focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      padding: EdgeInsets.all(_hasFocused ? 1:0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: style.textColorGradient,
      ),
      child: Container(
        height: 44,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey,
            width: _hasFocused ?0:1,
          ),
        ),
        child: Center(
          child: TextField(
            controller: widget.controller,
            focusNode: focusNode,
            cursorRadius: Radius.circular(100),
            cursorColor: Colors.black.withOpacity(.75),
            cursorWidth: 2,
            autocorrect: false,
            maxLines: (widget.autoMaxLine!=null && widget.autoMaxLine) ? null : 1,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: widget.hintText,
              contentPadding: EdgeInsets.all(0.0),
              hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black.withOpacity(.55),
                  fontWeight: FontWeight.w300
              ),
            ),
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }


}

class AppTextFieldWithTitle extends StatelessWidget with App {
  final String title;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final bool autoMaxLine;

  AppTextFieldWithTitle({
    Key key,
    @required this.title,
    @required this.hintText,
    @required this.controller,
    this.focusNode,
    this.obscureText= false,
    this.keyboardType= TextInputType.text,
    this.autoMaxLine,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 4.0, top: 24),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),
            textScaleFactor: size.fontFactor,
          ),
        ),
        AppTextField(
          autoMaxLine: autoMaxLine,
          controller: controller,
          hintText: hintText,
          obscureText: obscureText,
          keyboardType: keyboardType,
          focusNode: focusNode,
        ),
      ],
    );
  }
}
