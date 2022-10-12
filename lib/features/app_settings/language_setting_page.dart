import 'package:dei/universal/themes/bloc/theme_cubit.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../locator.dart';
import '../../universal/localization.dart';
import '../../universal/themes/app_themes.dart';
import '../../utilities/string_constatnts.dart';


class LanguageSettingPage extends StatefulWidget {
  static String routeName = '/languageSettingPage';

  @override
  ThemeSettingsPageState createState() => ThemeSettingsPageState();
}

class ThemeSettingsPageState extends State<LanguageSettingPage> {
  final prefs = getIt<SharedPreferences>();

  late ThemeCubit cubit;
  late AppTheme themeEnum;
  late bool isEnglish;

  @override
  void initState() {
    isEnglish = prefs.containsKey(languageCode)
        ? EnumToString.fromString(
                    LocalEnum.values, prefs.getString(languageCode)!) ==
                LocalEnum.en
            ? true
            : false
        : true;

    themeEnum = prefs.containsKey(themeCode)
        ? EnumToString.fromString(
                AppTheme.values, prefs.getString(themeCode)!) ??
            AppTheme.light
        : AppTheme.light;

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            Card(
              child: ListTile(
                title: Text(AppLocalizations.of(context)!.trans("english")),

                trailing: Checkbox(
                  value: isEnglish,
                  onChanged: (bool? value) {
                    setState(() {
                      isEnglish = value!;
                      prefs.setString(
                          languageCode,
                          EnumToString.convertToString(
                              value ? LocalEnum.en : LocalEnum.hi));
                      cubit.setNewTheme(
                          locale:
                              appLocale[value ? LocalEnum.en : LocalEnum.hi]!,
                          themeData: appThemeData[themeEnum]!);
                    });
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(AppLocalizations.of(context)!.trans("hindi")),
                trailing: Checkbox(
                  value: !isEnglish,
                  onChanged: (bool? value) {
                    setState(() {
                      isEnglish = (value!) ? false : true;
                      prefs.setString(
                          languageCode,
                          EnumToString.convertToString(
                              !value ? LocalEnum.en : LocalEnum.hi));
                      cubit.setNewTheme(
                          locale:
                              appLocale[!value ? LocalEnum.en : LocalEnum.hi]!,
                          themeData: appThemeData[themeEnum]!);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
