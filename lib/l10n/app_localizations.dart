import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt')
  ];

  /// No description provided for @language.
  ///
  /// In pt, this message translates to:
  /// **'Português'**
  String get language;

  /// No description provided for @wallet.
  ///
  /// In pt, this message translates to:
  /// **'Carteira'**
  String get wallet;

  /// No description provided for @details.
  ///
  /// In pt, this message translates to:
  /// **'Detalhes'**
  String get details;

  /// No description provided for @informations.
  ///
  /// In pt, this message translates to:
  /// **'Informações'**
  String get informations;

  /// No description provided for @transactions.
  ///
  /// In pt, this message translates to:
  /// **'Movimentações'**
  String get transactions;

  /// No description provided for @wallets.
  ///
  /// In pt, this message translates to:
  /// **'Carteiras'**
  String get wallets;

  /// No description provided for @actualvalue.
  ///
  /// In pt, this message translates to:
  /// **'Valor Atual'**
  String get actualvalue;

  /// No description provided for @marketcap.
  ///
  /// In pt, this message translates to:
  /// **'Cap. de Mercado'**
  String get marketcap;

  /// No description provided for @minimumvalue.
  ///
  /// In pt, this message translates to:
  /// **'Valor Mínimo'**
  String get minimumvalue;

  /// No description provided for @maximumvalue.
  ///
  /// In pt, this message translates to:
  /// **'Valor Máximo'**
  String get maximumvalue;

  /// No description provided for @convertcoin.
  ///
  /// In pt, this message translates to:
  /// **'Converter Moeda'**
  String get convertcoin;

  /// No description provided for @coin.
  ///
  /// In pt, this message translates to:
  /// **'Moeda'**
  String get coin;

  /// No description provided for @coinconversion.
  ///
  /// In pt, this message translates to:
  /// **'Conversão de Moeda'**
  String get coinconversion;

  /// No description provided for @amounttobeconverted.
  ///
  /// In pt, this message translates to:
  /// **'Montante a ser convertido'**
  String get amounttobeconverted;

  /// No description provided for @amountafterconversion.
  ///
  /// In pt, this message translates to:
  /// **'Montante após conversão'**
  String get amountafterconversion;

  /// No description provided for @toreceivein.
  ///
  /// In pt, this message translates to:
  /// **'Para receber em'**
  String get toreceivein;

  /// No description provided for @sucessfulycoinconversioncompleted.
  ///
  /// In pt, this message translates to:
  /// **'Conversão de moeda efetuada com sucesso'**
  String get sucessfulycoinconversioncompleted;

  /// No description provided for @completedconversion.
  ///
  /// In pt, this message translates to:
  /// **'Conversão efetuada'**
  String get completedconversion;

  /// No description provided for @confirm.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get cancel;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
