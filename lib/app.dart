import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xspace/bloc/news_bloc.dart';
import 'package:xspace/core/services/rocket/rocket_service.dart';
import 'package:xspace/routes/routes.dart';
import 'package:xspace/themes/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RocketBloc(spaceXService: SpaceXService()),
        ),
      ],
      child: MaterialApp(
        title: 'Xspace',
        debugShowCheckedModeBanner: false,
        theme: Themes.buildLightTheme(),
        initialRoute: Routes.initialRoute,
        routes: Routes.buildRoutes,
        onUnknownRoute:
            Routes.unknownRoute as Route<dynamic>? Function(RouteSettings)?,
      ),
    );
  }
}
