import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dei/features/app_settings/theme_settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utilities/size_config.dart';
import '../../home/ui/home_page.dart';
import 'package:config/Config.dart';

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

      setTimer();});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/images/bg_1.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(
                      APP_NAME,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
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
        () => Navigator.pushNamed(
              context,
            LofinPage.routeName
            ));
  }
}
