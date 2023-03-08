import 'package:flutter/material.dart';
import 'package:xspace/layout/base.dart';
import 'package:xspace/screens/00_splash/get_started.dart';
import 'package:xspace/screens/00_splash/splash.dart';
import 'package:xspace/screens/02_rocket_list/rocket_list_screen.dart';
import 'package:xspace/screens/03_rocket_details/rocket_details_screen.dart';
import 'package:xspace/screens/04_web_view/web_view_screen.dart';

/// [Routes] which contains common routing configuaration needed for the Application.
/// This includes all pages and all routes mapped to each other.
/// This also includes Routing table and Route for Unhandled routes.
/// Use [Routes] in MaterialApp:
///  ```dart
///  MaterialApp(
///    title: 'Flutter_App',
///    routes: Routes.buildRoutes,
///    initialRoute: Routes.login,
///    onUnknownRoute: Routes.unknownRoute,
///  );
///  ```

class Routes {
  Routes._();

  // routes
  static const splashScreen = '/splash-screen';
  static const getStartedScreen = '/get-started-screen';
  static const rocketListScreen = '/rocket-list-screen';
  static const rocketDetailsScreen = '/rocket-details-screen';
  static const webViewScreen = '/web-view-screen';

  /// Routing Table needed for the App.
  static Map<String, WidgetBuilder> get buildRoutes {
    return {
      splashScreen: (BuildContext context) => const BaseLayout(
            page: SplashScreen(),
            isAppBar: false,
          ),
      getStartedScreen: (BuildContext context) => const BaseLayout(
            page: GetStartedScreen(),
            isAppBar: false,
          ),
      rocketListScreen: (BuildContext context) => const BaseLayout(
            page: RocketListScreen(),
            isAppBar: false,
          ),
      rocketDetailsScreen: (BuildContext context) => const BaseLayout(
            page: RocketDetailsScreen(),
            isAppBar: false,
          ),
            webViewScreen: (BuildContext context) => const BaseLayout(
            page: WebViewScreen(),
            isAppBar: false,
          ),
    };
  }

  /// Handler for Error and Unhandled pages.
  static Function get unknownRoute {
    return (settings) {
      MaterialPageRoute(builder: (ctx) => const SizedBox());
    };
  }

  /// Configures the initial route.
  static String get initialRoute {
    return Routes.getStartedScreen;
  }
}
