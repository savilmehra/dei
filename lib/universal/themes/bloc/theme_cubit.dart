import 'package:dei/universal/themes/bloc/theme_localization_state.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../locator.dart';
import '../../../utilities/string_constatnts.dart';
import '../app_themes.dart';

class ThemeCubit extends Cubit<ThemeAndLocalizationState> {
  final SharedPreferences prefs;

  ThemeCubit(this.prefs)
      : super(ThemeAndLocalizationState(
            locale: appLocale[prefs.containsKey(languageCode)
                ? EnumToString.fromString(
                LocalEnum.values, prefs.getString(languageCode)!) ??
                LocalEnum.en
                : LocalEnum.en]!,
            themeData: appThemeData[prefs.containsKey(themeCode)
                ? EnumToString.fromString(
                        AppTheme.values, prefs.getString(themeCode)!) ??
                    AppTheme.light
                : AppTheme.light]!));

  setNewTheme({required ThemeData themeData, required Locale locale}) {
    emit(ThemeAndLocalizationState(themeData: themeData, locale: locale));
  }
}
