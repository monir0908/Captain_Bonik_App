import 'dart:async';
import 'package:captain_bonik_app/common/utils/app.dart';
import 'package:captain_bonik_app/common/utils/app_utils.dart';
import 'package:captain_bonik_app/common/utils/app_validator.dart';
import 'package:captain_bonik_app/common/utils/toasty.dart';
import 'package:captain_bonik_app/common/widgets/default_action_button.dart';
import 'package:captain_bonik_app/common/widgets/gradient_text.dart';
import 'package:captain_bonik_app/common/widgets/otp_text_field.dart';
import 'package:captain_bonik_app/common/widgets/rounded_corner.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class VerifyOTPPage extends StatefulWidget {
  final String appSignature;
  final bool isSignup;
  // final User user;
  const VerifyOTPPage({Key key,this.appSignature,@required this.isSignup,}) : super(key: key);

  @override
  _VerifyOTPPageState createState() => _VerifyOTPPageState();
}
class _VerifyOTPPageState extends State<VerifyOTPPage> with App,AppValidator {
  String _pinCode = "";
  final DefaultActionButtonController _defaultActionButtonController = DefaultActionButtonController();
  bool btnVisibility = false;
  bool btnVisibilityResend = false;

  Timer _timer;
  int _start = 120;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer){
      if(mounted)setState(() {
        if (_start < 1) {
          timer.cancel();
        } else {
          _start = _start - 1;
        }
      },
      );
    },);
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    App.initApp(context);
    return RoundedCorner(
      child: Stack(
        children: <Widget>[
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Image.asset(
          //     asset.bgTopShade,
          //     fit: BoxFit.fitWidth,
          //     //width: size.width,
          //   ),
          // ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Top Margin
              SizedBox(
                height: 24 + screen.padding.top,
                width: screen.size.width,
              ),
              // Gradient header
              Center(
                child: GradientText(
                  lbl.otpVerification,
                  gradient: style.textColorGradient,
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              // Form fields
              Expanded(
                child: Center(
                  child: KeyboardAvoider(
                    autoScroll: true,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 32.0, top: 24, right: 32, bottom: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 32.0, bottom: 8),
                            child: GradientText(
//                              "We have sent a 4 digit OTP to your mobile. Type your verification code and tap on \"Verify OTP\" button.",
                              lbl.otpDescription,
                              gradient: LinearGradient(
                                  colors: [Colors.lightGreen, Colors.blue]),
                              style: TextStyle(
                                //color: color.headerTextColorBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          //OTP input field
                          SizedBox(
                            height: 44,
                          ),
                          OTPTextField(
                            onPinChange: (x) {
                              _pinCode = x;
                              //Button visibility on check pin
                              if (isValidLength(_pinCode, 4, 4)){
                                btnVisibility = true;}
                              else{
                                btnVisibility = false;}
                              if (isValidLength(_pinCode, 1, 4)){
                                btnVisibilityResend = true;}
                              else{
                                btnVisibilityResend = false;}

                              /*Set State called */
                              setState(() {});
                            },
                            onAutoFill: (x) {
                              _pinCode = x;
                              _defaultActionButtonController.tap();
                            },
                          ),

                          SizedBox(
                            height: 32,
                          ),
                          _start != 0
                              ? Center(
                              child:!btnVisibilityResend? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.timer,
                                      size: 35, color: Color(0xff075B99)),
                                  Container(
                                    child: Text(
                                        label(
                                          e: ' $_start ${_start != 1 ? "seconds" : "second"}',
                                          b: '$_start সেকেন্ড',
                                        ),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff66B0D1))),
                                  )
                                ],
                              ):Offstage()
                          )
                              :
                          Center(child: !btnVisibilityResend? Container(
                            width: 200,
                            child: DefaultActionButton(
                              title: lbl.resendOTP,
                              tapAction: _invokeServerRequestResendOTP,
                              onSuccess: _onServerRequestSuccessResendOTP,
                              onError: _onServerRequestErrorResendOTP,
                            ),
                          ):Offstage(),
                          ),
                          // Register button
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                MediaQuery.of(context).size.width * .2),
                            child: AnimatedOpacity(
                              opacity: btnVisibility ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 500),
                              child: DefaultActionButton(
                                controller: _defaultActionButtonController,
                                title: lbl.otpVerifyOTP,
                                tapAction: _invokeServerRequest,
                                onSuccess: _onServerRequestSuccess,
                                onError: _onServerRequestError,
                                onCheck: _validateFormData,
                              ),
                            ),
                          ),
                          //Spinkit Indicator
                          // AnimatedOpacity(
                          //   opacity: !btnVisibility ? 1.0 : 0.0,
                          //   duration: Duration(milliseconds: 500),
                          //   child: SpinKitFadingCube(
                          //     itemBuilder: (_, int index) {
                          //       return DecoratedBox(
                          //         decoration: BoxDecoration(
                          //           color: index.isEven
                          //               ? Colors.blue[600]
                          //               : Colors.blue[200],
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // perform validation
  bool _validateFormData() {
    // FocusScope.of(context).requestFocus(FocusNode());
    // bool result = false;
    // if (isEmpty(_pinCode)) {
    //   Toasty.of(context).showWarning(lbl.otpAlert1);
    // } else if (!isValidLength(_pinCode, 4, 4)) {
    //   Toasty.of(context).showWarning(lbl.otpAlert2);
    // } else {
    //   return true;
    // }
    // return result;
  }

  // server request
  Future _invokeServerRequest() {
    // Toasty.of(context).lockUI();
    // int pin = int.parse(_pinCode);
    // if(widget.isSignup){
    //   return UserGateway.verifyOTPForRegistration(widget.user.mobileNumber, pin);
    // }else{
    //   return UserGateway.verifyOTP(widget.user.id, pin);
    // }
  }

  _onServerRequestSuccess(value) {
//     Toasty.of(context).releaseUI();
//     if (value.status == "OK") {
//       var data = HomePageDataResponse.fromJson(value.result);
//
//       print(data);
//       settings.setLocalData(data).then((x) {
// //        AnalyticsManager.updateUserSession(true);
//
//         //save fcm token
//         final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//         _firebaseMessaging.getToken().then((String token) {
//           //print("fcm token-$token");
//           UserGateway.saveFcmToken(x.user.id, token);
//         }).catchError((_) {
//           print("error getting local data");
//         });
//
//         Navigator.of(context)
//           ..pushAndRemoveUntil(
//               MaterialPageRoute(builder: (context) => UserLandPage()),
//               ModalRoute.withName('/root'));
//       }).catchError((x) {
//         Toasty.of(context).showError(lbl.otpAlert3);
//       });
//     } else {
//       Toasty.of(context).showError(value.messages);
//     }
  }

  _onServerRequestError(error) {
    Toasty.of(context).releaseUI();
    Toasty.of(context).showError(error.toString());
  }

  Future _invokeServerRequestResendOTP() {
    // Toasty.of(context).lockUI();
    // if(widget.isSignup){
    //   return UserGateway.registerUser(widget.user, widget.appSignature,widget.user.currentCourseId);
    // }else{
    //   return UserGateway.requestOTP(mobile: widget.user.mobileNumber, appSignature: widget.appSignature);
    // }
  }
  _onServerRequestSuccessResendOTP(value){
    Toasty.of(context).releaseUI();
    if ((value.status == "OK") || (value.status == "success")) {
      if(mounted)
        setState(() {
          _start=120;
        });
      startTimer();
    } else {
      Toasty.of(context).showError(value.message);
    }
  }
  _onServerRequestErrorResendOTP(error) {
    Toasty.of(context).releaseUI();
    Toasty.of(context).showError(error.toString());
  }
}
