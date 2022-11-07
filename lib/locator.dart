import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/products_showcase/db/sync_client_outbox.dart';
import 'locator.config.dart';
const emailKey="EmailKey";
const passwordKey="PasswordKey";
const defaultDuration = Duration(milliseconds: 250);
final getIt = GetIt.instance;
@module
abstract class InjectionModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
@injectableInit
Future<void> configureInjection(String env) async {
  getIt.registerSingleton<ObjectBoxSyncClient>(ObjectBoxSyncClient());
  await $initGetIt(getIt, environment: env);
}


