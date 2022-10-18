import 'package:dei/universal/themes/bloc/theme_cubit.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../locator.dart';
import '../../universal/localization.dart';
import '../../universal/themes/app_themes.dart';
import '../../utilities/string_constatnts.dart';


class ThemeSettingsPage extends StatefulWidget {
  static String routeName = '/themeSettingsPage';

  @override
  ThemeSettingsPageState createState() => ThemeSettingsPageState();
}

class ThemeSettingsPageState extends State<ThemeSettingsPage> {
  bool isDarkTheme = false;
  final prefs = getIt<SharedPreferences>();
  bool isCustomThemeTheme = false;
  late ThemeCubit cubit;
  late LocalEnum localEnum;

  @override
  void initState() {
    localEnum = prefs.containsKey(languageCode)
        ? EnumToString.fromString(
                LocalEnum.values, prefs.getString(languageCode)!) ??
            LocalEnum.en
        : LocalEnum.en;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit = context.read<ThemeCubit>();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.trans("themeSettingsTitle")),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    "Set Your desired theme settings here , you can add custom theme also !!",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  subtitle: Text("click swsitch button"),
                  title: Text(AppLocalizations.of(context)!.trans("darkTheme")),
                  leading: Switch(
                    onChanged: (bool value) {
                      setState(() {
                        isDarkTheme = value;
                        prefs.setString(themeCode,
                            EnumToString.convertToString(value ? AppTheme.dark : AppTheme.light));
                        cubit.setNewTheme(
                            locale: appLocale[localEnum]!,
                            themeData: appThemeData[
                                value ? AppTheme.dark : AppTheme.light]!);
                      });
                    },
                    value: isDarkTheme,
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(AppLocalizations.of(context)!.trans("customTheme")),
                  leading: Switch(
                    onChanged: (bool value) {
                      setState(() {
                        isCustomThemeTheme = value;
                        prefs.setString(themeCode,
                            EnumToString.convertToString( AppTheme.custom));
                        cubit.setNewTheme(
                            locale: appLocale[localEnum]!,
                            themeData: appThemeData[AppTheme.custom]!);
                      });
                    },
                    value: isCustomThemeTheme,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
