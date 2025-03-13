import 'package:eks/core/bloc_observer.dart';
import 'package:eks/core/network/local/remote/cache_helper.dart';
import 'package:eks/core/settigns/language/cubit/app_language_cubit.dart';
import 'package:eks/core/settigns/language/cubit/language_event_type.dart';
import 'package:eks/core/theme/theme.dart';
import 'package:eks/features/account_management/presentation/cubit/account_cubit.dart';
import 'package:eks/features/home/presentation/pages/app_home_page.dart';
import 'package:eks/features/product_management/presentation/cubit/product_cubit.dart';
import 'package:eks/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppLanguageCubit()
            ..appLanguageFunc(LanguageEventEnums.InitailLanguage),
        ),
        BlocProvider(
          create: (context) => AccountCubit(
              addDealerUseCase: di.sl(),
              addCustomerUseCase: di.sl(),
              addDelegateUseCase: di.sl(),
              updateDealerUseCase: di.sl(),
              updateCustomerUseCase: di.sl(),
              updateDelegateUseCase: di.sl(),
              deleteDealerUseCase: di.sl(),
              deleteCustomerUseCase: di.sl(),
              deleteDelegateUseCase: di.sl(),
              getAllDealersUseCase: di.sl(),
              getAllCustomersUseCase: di.sl(),
              getAllDelegatesUseCase: di.sl(),
          ),
        ),
        BlocProvider(
          create: (context) => ProductCubit(
              addProductUseCase: di.sl(),
              updateProductUseCase: di.sl(),
              deleteProductUseCase: di.sl(),
              getAllProductsUseCase: di.sl(),
              addUnitUseCase: di.sl(),
              getAllUnitsUseCase: di.sl(),
              updateUnitUseCase: di.sl(),
              deleteUnitUseCase: di.sl(),
          )

        ),
      ],
      child: BlocBuilder<AppLanguageCubit, AppLanguageState>(
        builder: (context, state) {
          final Locale? locale = state is AppChangeLanguage
              ? Locale(state.languageCode)
              : null;
          return buildMaterialApp(locale);
        },
      ),
    );
  }

  MaterialApp buildMaterialApp(Locale? locale) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        return deviceLocale != null &&
            supportedLocales.any((locale) =>
            locale.languageCode == deviceLocale.languageCode)
            ? deviceLocale
            : supportedLocales.first;
      },
      theme: AppTheme.lightThemeMode,
      home: const AppHomePage(),
    );
  }
}
