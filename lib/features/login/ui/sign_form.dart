import 'package:dei/features/home/ui/home_page.dart';
import 'package:flutter/material.dart';

import '../../../locator.dart';
import '../../../utilities/size_config.dart';
import 'default_button.dart';

typedef SignInFormCallback = Function(String userName, String passWord);

class SignForm extends StatefulWidget {
  final SignInFormCallback signInFormCallback;
  final VoidCallback onTapForgotPassword;
  final bool isLoading;

  SignForm(
      {required this.signInFormCallback,
      required this.onTapForgotPassword,
      this.isLoading = false});

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool remember = false;
  final List<String> errors = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void addError({String? error}) {
    if (error == null) return;
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                onChanged: (value) {
                  setState(() {
                    remember = value!;
                  });
                },
              ),
              Text("Show Password"),
              Spacer(),
              GestureDetector(
                onTap: () {
                  widget.onTapForgotPassword();
                  // Navigator.pushNamed(
                  //    context, ForgotPasswordScreen.routeName)
                },
                child: Text(
               "Forgot Password ?",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),

          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            key: Key('LoginButton'),

            isLoading: widget.isLoading,
            text:"Sign In",
            press: () {
              Navigator.pushNamed(
                  context,
                  HomePage.routeName
              );
              // }
            },
          ),
        ],
      ),
    );
  }

  Widget buildPasswordFormField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left:8.0,right: 8.0),
        child: TextFormField(
          key: Key(passwordKey),
          controller: TextEditingController(),
          obscureText: true,
          onSaved: (newValue) => password = newValue!,
          onChanged: (value) {

            return null;
          },
          validator: (value) {
            if (value != null) {

            }
            return null;
          },
          decoration: InputDecoration(
            labelText:
                "Password"
            ,
            hintText:
            "Enter Password",
            border: InputBorder.none,
            // If  you are using latest version of flutter then lable text and hint text shown like this
            // if you r using flutter less then 1.20.* then maybe this is not working properly
            floatingLabelBehavior: FloatingLabelBehavior.always,

          ),
        ),
      ),
    );
  }

  Widget buildEmailFormField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left:8.0,right: 8.0),
        child: TextFormField(
          key: Key(emailKey),
          keyboardType: TextInputType.emailAddress,
          controller: TextEditingController(),
          onSaved: (newValue) => email = newValue!,
          onChanged: (value) {

          },
          validator: (value) {

          },
          decoration: InputDecoration(
            labelText:
               "User Name",
            hintText:
             "Enter your Mail Id,Staff Id",
            border: InputBorder.none,
            // If  you are using latest version of flutter then lable text and hint text shown like this
            // if you r using flutter less then 1.20.* then maybe this is not working properly
            floatingLabelBehavior: FloatingLabelBehavior.always,

          ),
        ),
      ),
    );
  }


}

