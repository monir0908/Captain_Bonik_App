import 'package:captain_bonik_app/common/utils/app.dart';
import 'package:captain_bonik_app/common/utils/app_utils.dart';
import 'package:captain_bonik_app/common/widgets/app_text_field_with_title.dart';
import 'package:captain_bonik_app/common/widgets/default_action_button.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class SignInPage extends StatefulWidget {
  final ValueChanged onChanged;

  const SignInPage({Key key, this.onChanged}) : super(key: key);
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>with App {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  KeyboardAvoider(
      autoScroll: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(
            children: [
              SizedBox(
                height: 52,
              ),
              AppTextFieldWithTitle(
                controller: _nameController,
                title: lbl.phoneTitle,
                hintText: lbl.phoneHint,
              ),
              SizedBox(
                height: 60,
              ),
              DefaultActionButton(
                title: lbl.continueText,
                // tapAction: _onTap
              ),
              SizedBox(height: 80,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [
                    Text(label(
                        e: 'Are you new user ?',
                        b: 'আপনি কি নতুন ব্যবহারকারী ?'),
                      style: TextStyle(fontSize: 17,),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                        onTap: _signInPageStatus,
                        child: Text(label(e: 'Create an account', b: 'নতুন একাউন্ট তৈরি করুন'),style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700,color: Color(0xff006A4E),),))

                  ],)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signInPageStatus() {
    widget.onChanged('false');
  }

}
