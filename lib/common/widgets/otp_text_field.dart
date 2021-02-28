import 'package:captain_bonik_app/common/utils/app.dart';
import 'package:captain_bonik_app/common/utils/sms_retriver_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'gradient_text.dart';

class OTPTextField extends StatefulWidget {
  final ValueChanged<String> onPinChange;
  final ValueChanged<String> onAutoFill;
  final double spaceBetween;

  const OTPTextField({
    Key key,
    @required this.onPinChange,
    @required this.onAutoFill,
    this.spaceBetween = 16,
  }) : super(key: key);
  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> with App {
  final TextEditingController _textFieldController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Map<int, String> _pinList = {};
  String msgText;
  bool _autoPicked= false;

  @override
  void initState() {
    super.initState();
    SmsRetrieverApi.startListening().then((x){
      String smsCode = x;
      msgText = smsCode;
      if (msgText != null && msgText.length >= 8 && msgText.startsWith("<#> Use")) {
        var pin = msgText.substring(8, 12);
        _onTextChanged(pin);
        widget.onAutoFill(pin);
      }

      //stop listening for sms
      SmsRetrieverApi.stopListening();
      _autoPicked = true;
    }).catchError((_){
      print("sms error");
    });
  }
  @override
  void dispose() {
    if(!_autoPicked){
      SmsRetrieverApi.stopListening();
    }
    super.dispose();
  }
  void _onTextChanged(String text) {
    _pinList.forEach((x, y) {
      _pinList[x] = "";
    });

    for (int i = 0; i < text.length; i++) {
      _pinList[i] = text[i];
    }
    setState(() {});

    widget.onPinChange(text);
  }
  void _onPinBoxTap() async {
    if (!_focusNode.hasFocus) {
      _textFieldController.clear();
      _onTextChanged("");
      FocusScope.of(context).requestFocus(_focusNode);
    } else {
      _focusNode.unfocus();
      await Future.delayed(Duration(milliseconds: 50));
      _onPinBoxTap();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 0,
            width: 0,
            child: TextField(
                controller: _textFieldController,
                focusNode: _focusNode,
                onChanged: _onTextChanged,
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: false),
                style: TextStyle(
                  fontSize: .0001,
                  color: Colors.red,
                  decoration: TextDecoration.none,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                  FilteringTextInputFormatter.digitsOnly,
                ]),
          ),
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _PinBox(
                  pin: _pinList[0],
                  onTap: _onPinBoxTap,
                ),
                SizedBox(
                  width: widget.spaceBetween,
                ),
                _PinBox(
                  pin: _pinList[1],
                  onTap: _onPinBoxTap,
                ),
                SizedBox(
                  width: widget.spaceBetween,
                ),
                _PinBox(
                  pin: _pinList[2],
                  onTap: _onPinBoxTap,
                ),
                SizedBox(
                  width: widget.spaceBetween,
                ),
                _PinBox(
                  pin: _pinList[3],
                  onTap: _onPinBoxTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PinBox extends StatefulWidget {
  final String pin;
  final VoidCallback onTap;

  const _PinBox({Key key, this.pin, this.onTap}) : super(key: key);
  @override
  _PinBoxState createState() => _PinBoxState();
}

class _PinBoxState extends State<_PinBox> with App {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 48,
        width: 40,
        decoration: BoxDecoration(
          //color: Colors.black12,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black.withOpacity(.18), width: 1),
        ),
        child: Center(
          child: GradientText(
            widget.pin ?? "",
            gradient: style.textColorGradient,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
