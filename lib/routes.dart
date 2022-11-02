

import 'package:dei/features/app_settings/theme_settings_page.dart';
import 'package:dei/features/home/ui/webview_page.dart';
import 'package:dei/universal/authentication/local_authentication.dart';

import 'package:flutter/cupertino.dart';

import 'features/app_settings/language_setting_page.dart';
import 'features/home/ui/home_page.dart';
import 'features/home/ui/image_gallery.dart';
import 'features/home/ui/webview_new.dart';
import 'features/login/ui/login_page.dart';
import 'features/login/ui/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  GalleryImages.routeName: (context) => GalleryImages(),
  LofinPage.routeName: (context) => LofinPage(),
  HomePage.routeName: (context) => HomePage(),
  LanguageSettingPage.routeName:(context) => LanguageSettingPage(),

  SplashScreen.routeName: (context) => SplashScreen(),
  ThemeSettingsPage.routeName: (context) => ThemeSettingsPage(),
};
