import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:opennutritracker/core/data/data_source/user_data_source.dart';
import 'package:opennutritracker/core/data/repository/config_repository.dart';
import 'package:opennutritracker/core/domain/entity/app_theme_entity.dart';
import 'package:opennutritracker/core/presentation/main_screen.dart';
import 'package:opennutritracker/core/presentation/widgets/image_full_screen.dart';
import 'package:opennutritracker/core/styles/color_schemes.dart';
import 'package:opennutritracker/core/styles/fonts.dart';
import 'package:opennutritracker/core/utils/env.dart';
import 'package:opennutritracker/core/utils/locator.dart';
import 'package:opennutritracker/core/utils/logger_config.dart';
import 'package:opennutritracker/core/utils/navigation_options.dart';
import 'package:opennutritracker/core/utils/page_transitions.dart';
import 'package:opennutritracker/core/utils/theme_mode_provider.dart';
import 'package:opennutritracker/features/activity_detail/activity_detail_screen.dart';
import 'package:opennutritracker/features/add_meal/presentation/add_meal_screen.dart';
import 'package:opennutritracker/features/add_activity/presentation/add_activity_screen.dart';
import 'package:opennutritracker/features/edit_meal/presentation/edit_meal_screen.dart';
import 'package:opennutritracker/features/onboarding/onboarding_screen.dart';
import 'package:opennutritracker/features/scanner/scanner_screen.dart';
import 'package:opennutritracker/features/meal_detail/meal_detail_screen.dart';
import 'package:opennutritracker/features/settings/settings_screen.dart';
import 'package:opennutritracker/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LoggerConfig.intiLogger();
  await initLocator();
  final isUserInitialized = await locator<UserDataSource>().hasUserData();
  final configRepo = locator<ConfigRepository>();
  final hasAcceptedAnonymousData =
      await configRepo.getConfigHasAcceptedAnonymousData();
  final savedAppTheme = await configRepo.getConfigAppTheme();
  final log = Logger('main');

  // If the user has accepted anonymous data collection, run the app with
  // sentry enabled, else run without it
  if (kReleaseMode && hasAcceptedAnonymousData) {
    log.info('Starting App with Sentry enabled ...');
    _runAppWithSentryReporting(isUserInitialized, savedAppTheme);
  } else {
    log.info('Starting App ...');
    runAppWithChangeNotifiers(isUserInitialized, savedAppTheme);
  }
}

void _runAppWithSentryReporting(
    bool isUserInitialized, AppThemeEntity savedAppTheme) async {
  await SentryFlutter.init((options) {
    options.dsn = Env.sentryDns;
    options.tracesSampleRate = 1.0;
  },
      appRunner: () =>
          runAppWithChangeNotifiers(isUserInitialized, savedAppTheme));
}

void runAppWithChangeNotifiers(
        bool userInitialized, AppThemeEntity savedAppTheme) =>
    runApp(ChangeNotifierProvider(
        create: (_) => ThemeModeProvider(appTheme: savedAppTheme),
        child: OpenNutriTrackerApp(userInitialized: userInitialized)));

/// Route generation handler with custom page transitions
Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case NavigationOptions.mainRoute:
      return FadePageRoute(
        settings: settings,
        duration: const Duration(milliseconds: 300),
        builder: (_) => const MainScreen(),
      );

    case NavigationOptions.onboardingRoute:
      return FadePageRoute(
        settings: settings,
        builder: (_) => const OnboardingScreen(),
      );

    case NavigationOptions.settingsRoute:
      return SlideRightPageRoute(
        settings: settings,
        builder: (_) => const SettingsScreen(),
      );

    case NavigationOptions.addMealRoute:
      return SlideBottomPageRoute(
        settings: settings,
        builder: (_) => const AddMealScreen(),
      );

    case NavigationOptions.scannerRoute:
      return FadePageRoute(
        settings: settings,
        builder: (_) => const ScannerScreen(),
      );

    case NavigationOptions.mealDetailRoute:
      return SlideRightPageRoute(
        settings: settings,
        builder: (_) => const MealDetailScreen(),
      );

    case NavigationOptions.editMealRoute:
      return SlideRightPageRoute(
        settings: settings,
        builder: (_) => const EditMealScreen(),
      );

    case NavigationOptions.addActivityRoute:
      return SlideBottomPageRoute(
        settings: settings,
        builder: (_) => const AddActivityScreen(),
      );

    case NavigationOptions.activityDetailRoute:
      return SlideRightPageRoute(
        settings: settings,
        builder: (_) => const ActivityDetailScreen(),
      );

    case NavigationOptions.imageFullScreenRoute:
      return ZoomPageRoute(
        settings: settings,
        builder: (_) => const ImageFullScreen(),
      );

    default:
      // Fallback for unknown routes
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('Route not found')),
          body: const Center(child: Text('Route not found')),
        ),
      );
  }
}

class OpenNutriTrackerApp extends StatelessWidget {
  final bool userInitialized;

  const OpenNutriTrackerApp({super.key, required this.userInitialized});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => S.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          textTheme: appTextTheme),
      darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          textTheme: appTextTheme),
      themeMode: Provider.of<ThemeModeProvider>(context).themeMode,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      initialRoute: userInitialized
          ? NavigationOptions.mainRoute
          : NavigationOptions.onboardingRoute,
      onGenerateRoute: _onGenerateRoute,
    );
  }
}
