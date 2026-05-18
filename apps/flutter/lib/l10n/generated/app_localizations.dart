import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'Nyrex'**
  String get appName;

  /// App tagline shown on the welcome screen
  ///
  /// In en, this message translates to:
  /// **'Your personal toolkit'**
  String get tagline;

  /// Primary login button label
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get actionLogin;

  /// Primary register button label
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get actionRegister;

  /// Button label to log out
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get actionLogout;

  /// Button label to continue
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get actionContinue;

  /// Button label to cancel
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// Button label to save
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionSave;

  /// Button label to retry
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get actionRetry;

  /// Label for email field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get labelEmail;

  /// Label for password field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get labelPassword;

  /// Label for confirm password field
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get labelConfirmPassword;

  /// Label for username field
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get labelUsername;

  /// Hint for email field
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get hintEmail;

  /// Hint for password field
  ///
  /// In en, this message translates to:
  /// **'••••••••'**
  String get hintPassword;

  /// Title for the login screen
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get loginTitle;

  /// Subtitle for the login screen
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue to Nyrex'**
  String get loginSubtitle;

  /// Text indicating the user doesn't have an account
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get loginNoAccount;

  /// Title for the register screen
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get registerTitle;

  /// Subtitle for the register screen
  ///
  /// In en, this message translates to:
  /// **'Join Nyrex — your data, your rules.'**
  String get registerSubtitle;

  /// Text indicating the user has an account
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get registerHaveAccount;

  /// Error message for required fields
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get errorRequired;

  /// Error message for invalid email
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get errorInvalidEmail;

  /// Error message for password too short
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get errorPasswordTooShort;

  /// Error message for password mismatch
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get errorPasswordMismatch;

  /// Error message for unexpected errors
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorUnexpected;

  /// Error message for network unavailable
  ///
  /// In en, this message translates to:
  /// **'Cannot reach the server. Check your connection.'**
  String get errorNetworkUnavailable;

  /// Error message for invalid credentials
  ///
  /// In en, this message translates to:
  /// **'Email or password is incorrect'**
  String get errorInvalidCredentials;

  /// Theme label
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeLabel;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// AMOLED theme option
  ///
  /// In en, this message translates to:
  /// **'AMOLED'**
  String get themeAmoled;

  /// Search bar placeholder
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get hintSearch;

  /// Command palette search placeholder
  ///
  /// In en, this message translates to:
  /// **'Search or execute command...'**
  String get hintCommandPalette;

  /// Quick capture input placeholder
  ///
  /// In en, this message translates to:
  /// **'Quick capture — type a task, add !priority #tags due:date...'**
  String get hintQuickCapture;

  /// Title shown when search returns no results
  ///
  /// In en, this message translates to:
  /// **'No results'**
  String get emptySearchTitle;

  /// Description shown when search returns no results
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your search query.'**
  String get emptySearchDescription;

  /// Command palette keyboard hint for navigation
  ///
  /// In en, this message translates to:
  /// **'↑ ↓ navigate'**
  String get commandPaletteNavigate;

  /// Command palette keyboard hint for selection
  ///
  /// In en, this message translates to:
  /// **'↵ select'**
  String get commandPaletteSelect;

  /// Default group name in command palette
  ///
  /// In en, this message translates to:
  /// **'OTHER'**
  String get commandPaletteGroupOther;

  /// Sync badge label when synced
  ///
  /// In en, this message translates to:
  /// **'SYNCED'**
  String get syncStatusSynced;

  /// Sync badge label when offline
  ///
  /// In en, this message translates to:
  /// **'OFFLINE'**
  String get syncStatusOffline;

  /// Sync indicator label when syncing
  ///
  /// In en, this message translates to:
  /// **'Syncing...'**
  String get syncStatusSyncing;

  /// Sync indicator label when synced
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get syncIndicatorSynced;

  /// Sync indicator label when offline
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get syncIndicatorOffline;

  /// Button label to launch/open an entry
  ///
  /// In en, this message translates to:
  /// **'Launch'**
  String get actionLaunch;

  /// Button label to delete a vault entry
  ///
  /// In en, this message translates to:
  /// **'Delete Entry'**
  String get actionDeleteEntry;

  /// Section header for tags
  ///
  /// In en, this message translates to:
  /// **'TAGS'**
  String get labelTags;

  /// Section header for metadata
  ///
  /// In en, this message translates to:
  /// **'METADATA'**
  String get labelMetadata;

  /// Default breadcrumb for vault list pane
  ///
  /// In en, this message translates to:
  /// **'VAULT  /  All entries'**
  String get breadcrumbVaultAll;

  /// Navigation: Home
  ///
  /// In en, this message translates to:
  /// **'HOME'**
  String get navHome;

  /// Navigation: Today
  ///
  /// In en, this message translates to:
  /// **'TODAY'**
  String get navToday;

  /// Navigation: Pinned
  ///
  /// In en, this message translates to:
  /// **'PINNED'**
  String get navPinned;

  /// Navigation: Modules
  ///
  /// In en, this message translates to:
  /// **'MODULES'**
  String get navModules;

  /// Navigation: Views
  ///
  /// In en, this message translates to:
  /// **'VIEWS'**
  String get navViews;

  /// Navigation: Projects
  ///
  /// In en, this message translates to:
  /// **'PROJECTS'**
  String get navProjects;

  /// Navigation: Categories
  ///
  /// In en, this message translates to:
  /// **'CATEGORIES'**
  String get navCategories;

  /// Navigation: Tags
  ///
  /// In en, this message translates to:
  /// **'TAGS'**
  String get navTags;

  /// Module: Studio
  ///
  /// In en, this message translates to:
  /// **'Studio'**
  String get moduleStudio;

  /// Module: Focus list
  ///
  /// In en, this message translates to:
  /// **'Focus list'**
  String get moduleFocusList;

  /// Module: Agenda
  ///
  /// In en, this message translates to:
  /// **'Agenda'**
  String get moduleAgenda;

  /// Module: Notes
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get moduleNotes;

  /// Module: Vault
  ///
  /// In en, this message translates to:
  /// **'Vault'**
  String get moduleVault;

  /// Module: Tasks
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get moduleTasks;

  /// Module: Finance
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get moduleFinance;

  /// View: Today
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get viewToday;

  /// View: Upcoming
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get viewUpcoming;

  /// View: All
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get viewAll;

  /// View: Completed
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get viewCompleted;

  /// Category: Logins
  ///
  /// In en, this message translates to:
  /// **'Logins'**
  String get catLogins;

  /// Category: Cards
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get catCards;

  /// Category: Secure notes
  ///
  /// In en, this message translates to:
  /// **'Secure notes'**
  String get catSecureNotes;

  /// Category: SSO
  ///
  /// In en, this message translates to:
  /// **'SSO'**
  String get catSSO;

  /// Action: Quick capture
  ///
  /// In en, this message translates to:
  /// **'+ Quick capture'**
  String get actionQuickCapture;

  /// Action: New entry
  ///
  /// In en, this message translates to:
  /// **'+ New entry'**
  String get actionNewEntry;

  /// Action: New note
  ///
  /// In en, this message translates to:
  /// **'+ New note'**
  String get actionNewNote;

  /// Greeting: Good morning
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get greetingMorning;

  /// Greeting: Good afternoon
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get greetingAfternoon;

  /// Greeting: Good evening
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get greetingEvening;

  /// Dashboard section label: System
  ///
  /// In en, this message translates to:
  /// **'SYSTEM'**
  String get dashSystemLabel;

  /// Dashboard section label: Financial pulse
  ///
  /// In en, this message translates to:
  /// **'FINANCIAL PULSE'**
  String get dashFinancialPulse;

  /// Dashboard widget label: Net worth
  ///
  /// In en, this message translates to:
  /// **'Net Worth'**
  String get dashNetWorth;

  /// Dashboard widget label: Monthly burn
  ///
  /// In en, this message translates to:
  /// **'Monthly Burn'**
  String get dashMonthlyBurn;

  /// Dashboard widget label: Savings rate
  ///
  /// In en, this message translates to:
  /// **'Savings Rate'**
  String get dashSavingsRate;

  /// Dashboard section label: Cash flow
  ///
  /// In en, this message translates to:
  /// **'CASH FLOW'**
  String get dashCashFlow;

  /// Dashboard section label: Unified agenda
  ///
  /// In en, this message translates to:
  /// **'UNIFIED AGENDA'**
  String get dashUnifiedAgenda;

  /// Dashboard section label: Budget items
  ///
  /// In en, this message translates to:
  /// **'BUDGET ITEMS'**
  String get dashBudgetItems;

  /// Dashboard section label: Savings goals
  ///
  /// In en, this message translates to:
  /// **'SAVINGS GOALS'**
  String get dashSavingsGoals;

  /// Dashboard section label: Debt exposure
  ///
  /// In en, this message translates to:
  /// **'DEBT EXPOSURE'**
  String get dashDebtExposure;

  /// Dashboard section label: Quick actions
  ///
  /// In en, this message translates to:
  /// **'QUICK ACTIONS'**
  String get dashQuickActions;

  /// Dashboard action: New note
  ///
  /// In en, this message translates to:
  /// **'New Note'**
  String get dashNewNote;

  /// Dashboard action: New entry
  ///
  /// In en, this message translates to:
  /// **'New Entry'**
  String get dashNewEntry;

  /// Dashboard action: Add task
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get dashAddTask;

  /// Dashboard action: Log expense
  ///
  /// In en, this message translates to:
  /// **'Log Expense'**
  String get dashLogExpense;

  /// Dashboard section label: Focus tasks
  ///
  /// In en, this message translates to:
  /// **'FOCUS TASKS'**
  String get dashFocusTasks;

  /// Dashboard section label: Recent notes
  ///
  /// In en, this message translates to:
  /// **'RECENT NOTES'**
  String get dashRecentNotes;

  /// Dashboard section label: System
  ///
  /// In en, this message translates to:
  /// **'SYSTEM'**
  String get dashSystem;

  /// Dashboard widget label: Storage
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get dashStorage;

  /// Dashboard widget label: Sync
  ///
  /// In en, this message translates to:
  /// **'Sync'**
  String get dashSync;

  /// Dashboard widget label: Encryption
  ///
  /// In en, this message translates to:
  /// **'Encryption'**
  String get dashEncryption;

  /// Dashboard widget label: Version
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get dashVersion;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
