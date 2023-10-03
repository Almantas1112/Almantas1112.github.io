import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gov_tech/blocs/map_manager/map_manager_cubit.dart';
import 'package:gov_tech/blocs/map_tapped/map_tapped_cubit.dart';
import 'package:gov_tech/blocs/services/services_cubit.dart';
import 'package:gov_tech/data/repository.dart';
import 'package:gov_tech/di/app_injector.dart';
import 'package:gov_tech/ui/screens/main_menu.dart';

import 'constants/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  AppInjector.setupInjector();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('lt'),
      ],
      path: 'assets/lang',
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GetIt _getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MapManagerCubit(
            repo: _getIt.get<Repository>(),
          ),
        ),
        BlocProvider(create: (_) => MapTappedCubit()),
        BlocProvider(
          create: (_) => ServicesCubit(
            repo: _getIt.get<Repository>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Gov-tech',
        theme: AppTheme.themeData,
        darkTheme: AppTheme.themeDataDark,
        home: const MainMenu(),
      ),
    );
  }
}
