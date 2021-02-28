import 'package:captain_bonik_app/common/pages/verify_otp_page.dart';
import 'package:captain_bonik_app/common/utils/app.dart';
import 'package:captain_bonik_app/common/utils/app_utils.dart';
import 'package:captain_bonik_app/common/utils/sms_retriver_api.dart';
import 'package:captain_bonik_app/common/widgets/app_text_field_with_title.dart';
import 'package:captain_bonik_app/common/widgets/default_action_button.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class SignUpPage extends StatefulWidget {
  final ValueChanged onChanged;

  const SignUpPage({Key key, this.onChanged}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>with App {
  final _nameController = TextEditingController();
  String appSignature;
  @override
  void initState() {
    super.initState();
    startOtpVerification();
  }


  @override
  Widget build(BuildContext context) {
    return  KeyboardAvoider(
      autoScroll: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(
            children:  [
              AppTextFieldWithTitle(
                controller: _nameController,
                title: lbl.nameTitle,
                hintText: lbl.nameHint,
              ),
              AppTextFieldWithTitle(
                controller: _nameController,
                title: lbl.phoneTitle,
                hintText: lbl.phoneHint,
              ),
              AppTextFieldWithTitle(
                controller: _nameController,
                title: lbl.emailTitle,
                hintText: lbl.emailHint,
              ),
              SizedBox(
                height: 48,
              ),
              DefaultActionButton(
                title: lbl.continueText,
                tapAction: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => VerifyOTPPage(appSignature: appSignature,)));

                },
              ),
              SizedBox(height: 80,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(label(
                      e: 'Already have an account ?',
                      b: 'ইতিমধ্যে আপনার একাউন্ট আছে ? '),style: TextStyle(fontSize: 17,),),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: _signUpPageStatus,
                      child: Text(label(e: 'log in', b: 'লগ ইন'),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Color(0xff006A4E),),))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _signUpPageStatus() {
    widget.onChanged('false');
  }
  void startOtpVerification() {
    SmsRetrieverApi.getAppSignature().then((signature) {
      //print("sig -$signature");
      appSignature = signature;
    }).catchError((_) {
      print("sms error");
    });
  }
}
