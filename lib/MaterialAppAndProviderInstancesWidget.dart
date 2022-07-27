import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:work_project/CompletedConversionScreen.dart';
import 'package:work_project/Models/DetailsPageModel.dart';
import 'package:work_project/TabBar.dart';
import 'package:work_project/l10n/app_localizations.dart';

import '../StateController.dart';
import 'CoinConversion.dart';

class MaterialAppAndProviderInstancesWidget extends StatefulWidget {
  const MaterialAppAndProviderInstancesWidget({Key? key}) : super(key: key);

  @override
  State<MaterialAppAndProviderInstancesWidget> createState() =>
      MaterialAppAndProviderInstancesState();
}

class MaterialAppAndProviderInstancesState
    extends State<MaterialAppAndProviderInstancesWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: L10n.all,
        initialRoute: '/',
        routes: {
          '/': (context) => ChangeNotifierProvider(
                create: (context) => StoreSharedStateControllers(),
                child: const BottomNavigationBarWidget(),
              ),
          BottomNavigationBarWidget.selectedCriptoScreen: (context) =>
              ChangeNotifierProvider(
                  create: (context) => StoreSharedStateControllers(),
                  child: const DetailsPageModelWidget()),
          'coinConversion': (context) => ChangeNotifierProvider(
              create: (context) => StoreSharedStateControllers(),
              child: const CoinsConversionWidget()),
          '/completedConversion': (context) => const CompletedConversionScreen()
        });
  }
}

class ScreenArguments {
  final String symbol;

  ScreenArguments(this.symbol);
}

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('pt'),
    const Locale('es'),
  ];
}
