import 'package:get_it/get_it.dart';
import 'package:gov_tech/data/network/api/auth.dart';
import 'package:gov_tech/data/network/api/data.dart';
import 'package:gov_tech/data/network/dio_client.dart';
import 'package:gov_tech/data/repository.dart';

class AppInjector {
  static GetIt getIt = GetIt.instance;

  static void setupInjector() {
    _setupDio();
    _setupApi();
    _setupRepo();
  }

  static void _setupDio() {
    getIt.registerSingleton(DioClient());
  }

  static void _setupApi() {
    getIt.registerSingleton(DataApi());
    getIt.registerSingleton(AuthApi());
  }

  static void _setupRepo() {
    getIt.registerSingleton<Repository>(
      Repository(
        getIt<AuthApi>(),
        getIt<DataApi>(),
      ),
    );
  }
}
