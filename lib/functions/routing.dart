import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:res_q/pages/home_page.dart';
import 'package:res_q/pages/login_page.dart';
import 'package:res_q/pages/profile_page.dart';
import 'package:res_q/pages/splashscreen.dart';

import '../pages/maps.dart';

/// The route configuration.
final GoRouter _router = GoRouter(
  initialLocation: '/splashscreen',
  routes: <GoRoute>[
    GoRoute(
      path: '/splashscreen',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
      routes: [
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          path: 'dashboard',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
        ),
        GoRoute(
          path: 'profile',
          builder: (BuildContext context, GoRouterState state) {
            return const ProfilePage();
          },
        ),
        GoRoute(
          path: 'map',
          builder: (BuildContext context, GoRouterState state) {
            return const DirectionPage();
          },
        ),
      ],
    ),
  ],
  debugLogDiagnostics: true,
);

class Router extends StatelessWidget {
  const Router({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,

    );
  }
}
