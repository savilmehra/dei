import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utilities/size_config.dart';

import 'package:config/Config.dart';

import '../../dashboard/presentation/home_screen.dart';
import '../../home/ui/image_gallery.dart';
import '../../home/ui/webview_page.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/splashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SizeConfig().init(context);

      setTimer();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Stack(
        children: [
          Container(
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  APP_NAME,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontSize: getProportionateScreenWidth(36),
                      ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }

  Future<void> setTimer() async {
    Timer(
        const Duration(seconds: 5),
        () =>     Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  WebViewPage(updateCallBack: (url){

          }, url: "https://picsum.photos/200/300",)),
        ));
  }
}
