

import 'package:dei/features/products_showcase/bloc/product_cubit.dart';
import 'package:dei/routes.dart';
import 'package:dei/universal/localization.dart';
import 'package:dei/universal/themes/bloc/theme_cubit.dart';
import 'package:dei/universal/themes/bloc/theme_localization_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/splash/ui/splash_screen.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Environment.prod);
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final prefs = getIt<SharedPreferences>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductCubit()),
        BlocProvider(create: (context) => ThemeCubit(prefs))
      ],
      child: BlocBuilder<ThemeCubit, ThemeAndLocalizationState>(
        builder: (context, state) {
          return MaterialApp(
            theme: state.themeData,
            initialRoute: SplashScreen.routeName,
            routes: routes,
            locale: state.locale,
            localizationsDelegates: const [
               AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('hi', ''),
            ],
          );
        },
      ),
    );
  }
}
