import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:dei/universal/graphql/repository_graphql.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/products_showcase/db/out_box_helper.dart';
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
  getIt.registerSingleton<OutBoxHelper>(OutBoxHelper());
  getIt.registerSingleton<ObjectBoxSyncClient>(ObjectBoxSyncClient());
  await $initGetIt(getIt, environment: env);
}



ApplicationLocator locator() => ApplicationLocator();

Logger logger() => ApplicationLocator().logger;

class ApplicationLocator implements Locator {
  ApplicationLocator._();

  factory ApplicationLocator() {
    Locator.init(ApplicationLocator._());
    return Locator.getInstance();
  }

  @override
  Connectivity connectivity = AlwaysOnlineConnectivity();

  @override
  Logger logger = ConsoleLogger(LogLevel.nothing);
  SimpleRestApi api = SimpleRestApi(
    baseUrl: 'https://2-4-latest-xauwnsa-k6a3y7n5cxo3u.us-4.magentosite.cloud',
  );

  Repository repo = Repository();
  RepositoryGraphql repositoryGql = RepositoryGraphql();

  void dispose() => Locator.dispose();
}
