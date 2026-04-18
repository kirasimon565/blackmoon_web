import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'routes.dart';
import '../features/home/home_page.dart';
import '../features/dreadmoor/dreadmoor_page.dart';
import '../features/tracker/tracker_page.dart';
import '../features/contact/contact_page.dart';
import '../shared/layout/main_scaffold.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.home,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: AppRoutes.dreadmoor,
          builder: (context, state) => const DreadmoorPage(),
        ),
        GoRoute(
          path: AppRoutes.tracker,
          builder: (context, state) => const TrackerPage(),
        ),
        GoRoute(
          path: AppRoutes.contact,
          builder: (context, state) => const ContactPage(),
        ),
      ],
    ),
  ],
);
