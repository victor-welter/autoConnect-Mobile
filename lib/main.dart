import 'package:auto_connect_mobile/router_app.dart';
import 'package:auto_connect_mobile/services/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'configs/constants.dart';
import 'configs/routes/local_routes.dart';
import 'configs/theme/theme_app.dart';
import 'services/navigator_service.dart';
import 'view/rota-error-widget/rota_error_widget_view.dart';
import 'widgets/no_glow_effect.dart';

final routeObserver = RouteObserver<PageRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();

  LicenseRegistry.addLicense(() async* {
    final kleeOneLicence = await rootBundle.loadString('fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], kleeOneLicence);
  });

  ErrorWidget.builder = (errorDetails) => const RotaErrorWidgetView();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: App.NAME,
      themeMode: ThemeMode.light,
      theme: ThemeApp.ligthTheme,
      color: theme.primaryColor,
      navigatorKey: getIt<NavigationService>().navigatorKey,
      navigatorObservers: [routeObserver],
      builder: (context, child) {
        if (!getIt.isRegistered<BuildContext>()) {
          getIt.registerSingleton<BuildContext>(context);
        }

        return ScrollConfiguration(
          behavior: const NoGlowEffect(),
          child: child!,
        );
      },
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [Locale('pt', 'BR')],
      initialRoute: LocalRoutes.SPLASH_SCREEN,
      onGenerateRoute: RouterApp.onGenerateRoute,
    );
  }
}
