import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'detail_screen.dart';
import 'list_screen.dart';

const largeScreenSize = 600;

void main() {
  runApp(MyApp());
}

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
      title: 'GoRouter Example',
    );
  }

  final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/list',
    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: <RouteBase>[
          /// In case of narrow screen
          GoRoute(
            path: '/list',
            builder: (BuildContext context, GoRouterState state) {
              return const ListScreen();
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'detail/:index',
                builder: (BuildContext context, GoRouterState state) {
                  final index = state.params['index'];
                  return DetailScreen(index: index!);
                },
              ),
            ],
          ),

          /// In case of large screen
          GoRoute(
            path: '/list/:index',
            builder: (BuildContext context, GoRouterState state) {
              final index = state.params['index'];
              return ListScreen(
                argIndex: index,
              );
            },
          ),
        ],
      ),
    ],
  );
}

class ScaffoldWithNavBar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
}
