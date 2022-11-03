
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import '../../../components/color_constant.dart';
import '../../../utilities/size_config.dart';
import '../../login/ui/default_button.dart';
import 'dialog_util.dart';


Widget header({required bool isLogin, required BuildContext context}) {
  return Container(
    color: Colors.black,
    padding: EdgeInsets.symmetric(horizontal: 25.0),
    height: 60.0,
    child: MoveWindow(
      child: Row(
        children: [
          _logoContainer(),
          SizedBox(
            width: 170.0,
          ),
          Row(
            children: const [
              Icon(
                Icons.location_on_outlined,
                color: Colors.white,
                size: 15.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'Burj Khalifa, Dubai',
                style: TextStyle(fontSize: 12.0, color: Colors.white),
              )
            ],
          ),
          SizedBox(
            width: 25.0,
          ),
          Expanded(
            child: Row(
              children: const [
                Icon(
                  Icons.cloud_outlined,
                  color: Colors.white,
                  size: 15.0,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '36 C | 96.8 F',
                  style: TextStyle(fontSize: 12.0, color: Colors.white),
                )
              ],
            ),
          ),
          isLogin
              ? Row(
                  children: [
                    Text(
                      'Shift Start: --:--',
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    SizedBox(
                      width: 200.0,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.notifications_none_outlined,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 40.0,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            DialogUtil.notificationDialog(context);
                          },
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    ),
  );
}

Widget _logoContainer() {
  return const Image(
    image: AssetImage('assets/images/logo.png'),
    height: 19.0,
    width: 38.0,
  );
}

Widget headingMenu() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      children: [
        associateHeadingMenu(
            'View Brief', 'assets/images/dashboard/view_brief.png'),
        SizedBox(
          width: getProportionateScreenHeight(20.0),
        ),
        associateHeadingMenu(
            'Petty Cash', 'assets/images/dashboard/petty_cash.png'),
        SizedBox(
          width: getProportionateScreenHeight(20.0),
        ),
        associateHeadingMenu(
            'Consumables List', 'assets/images/dashboard/day_open_form.png'),
        SizedBox(
          width: getProportionateScreenHeight(20.0),
        ),
        associateHeadingMenu(
            'Raise Ticket', 'assets/images/dashboard/raise_ticket.png'),
      ],
    ),
  );
}

Widget smHeadingList() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      children: [
        smHeadingMenu(
            'Create/Edit Brief', 'assets/images/dashboard/view_brief.png'),
        SizedBox(
          width: getProportionateScreenHeight(20.0),
        ),
        smHeadingMenu(
            'Petty Cash', 'assets/images/dashboard/petty_cash.png'),
        SizedBox(
          width: getProportionateScreenHeight(20.0),
        ),
        smHeadingMenu(
            'Day Open Form', 'assets/images/dashboard/day_open_form.png'),
        SizedBox(
          width: getProportionateScreenHeight(20.0),
        ),
        smHeadingMenu(
            'Raise Ticket', 'assets/images/dashboard/raise_ticket.png'),
        SizedBox(
          width: getProportionateScreenHeight(20.0),
        ),
        smHeadingMenu(
            'Attendance', 'assets/images/dashboard/raise_ticket.png'),
      ],
    ),
  );
}

Widget associateHeadingMenu(String title, String img) {
  print(SizeConfig.screenWidth! * 0.019);
  return Expanded(
    child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth! * 0.019,
                vertical: SizeConfig.screenWidth! * 0.027),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: kBoxBorderColor),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(10.0),
                right: Radius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                Container(
                  child: Image(
                    image: AssetImage(img),
                    height: 18.0,
                    width: 18.0,
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenHeight(15.0),
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: SizeConfig.screenWidth!!! * 0.0123,
                      color: Colors.black),
                ),
              ],
            )),
  );
}

Widget smHeadingMenu(String title, String img) {
  print(SizeConfig.screenWidth! * 0.019);
  return Expanded(
    child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth! * 0.019,
            vertical: SizeConfig.screenWidth! * 0.019),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: kBoxBorderColor),
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(10.0),
            right: Radius.circular(10.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: AssetImage(img),
              height: 18.0,
              width: 18.0,
            ),
            verticalSpace(27.0),
            Text(
              title,
              style: TextStyle(
                  fontSize: SizeConfig.screenWidth!!! * 0.0123,
                  color: Colors.black),
            ),
          ],
        )),
  );
}

Widget windowButtons() {
  return Row(
    children: [
      MinimizeWindowButton(colors: WindowButtonColors(normal: Colors.black)),
      MaximizeWindowButton(colors: WindowButtonColors(normal: Colors.black)),
      CloseWindowButton(colors: WindowButtonColors(normal: Colors.black)),
    ],
  );
}

Widget dashboardHeading(BuildContext context, String type) {
  return Container(
    margin: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: kBoxBorderColor),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(10.0),
        right: Radius.circular(10.0),
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: 'Welcome, ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.screenWidth! * 0.0139,
                        fontWeight: FontWeight.w400)),
                TextSpan(
                    text: type,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.screenWidth! * 0.0139,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
        Text(
          'Start your day by marking attendance',
          style: TextStyle(
              fontSize: SizeConfig.screenWidth! * 0.0108, color: Colors.black),
        ),
        SizedBox(
          width: getProportionateScreenHeight(20.0),
        ),
        DefaultButton(

          text: "Start Day",
          press: () {},
        ),
      ],
    ),
  );
}

Widget quickSignIn({required String name, required String img}) {
  return Column(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Image(
          image: AssetImage(img),
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        name,
        style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white),
      ),
    ],
  );
}

Widget loginField(
    {required String hintText,
    required String labelText,
    required bool obscureText}) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(10.0),
        right: Radius.circular(10.0),
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: TextField(
      style: TextStyle(color: Colors.black),
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
      ),
    ),
  );
}

Widget fingerprintScreen() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        child: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                  text: 'Sign In ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: 'With \nFinger Print',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w200)),
            ],
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 45.0),
        height: 60.0,
        width: 60.0,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fingerprint.png'),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 45.0),
        child: const Center(
            child: Text(
          'Place your finger on the finger \nprint reader',
          textAlign: TextAlign.center,
          style:
              TextStyle(height: 2, fontWeight: FontWeight.w200, fontSize: 16.0),
        )),
      ),
    ],
  );
}

Widget verticalSpace(double height) {
  return SizedBox(height: getProportionateScreenHeight(height));
}

Widget horizontalSpace(double width) {
  return SizedBox(width: getProportionateScreenHeight(width));
}

Widget normalText({required String title, required double size, required Color color, required FontWeight weight}){
  return Text(
   title,
    style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight:weight),
  );
}
