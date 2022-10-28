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
      /// Application shell
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: <RouteBase>[
          /// The first screen to display in the bottom navigation bar.
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

          /// Displayed when the second item in the the bottom navigation bar is
          /// selected.
          GoRoute(
            path: '/large-list/:index',
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
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'List',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.business),
      //       label: 'List with ID',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notification_important_rounded),
      //       label: 'Detail',
      //     ),
      //   ],
      //   currentIndex: _calculateSelectedIndex(context),
      //   onTap: (int idx) => _onItemTapped(idx, context),
      // ),
    );
  }

  // static int _calculateSelectedIndex(BuildContext context) {
  //   final GoRouter route = GoRouter.of(context);
  //   final String location = route.location;
  //   if (location.startsWith('/list')) {
  //     return 0;
  //   }
  //   if (location.startsWith('/large-list')) {
  //     return 1;
  //   }
  //   if (location.startsWith('/list/detail')) {
  //     return 2;
  //   }
  //   return 0;
  // }

  // void _onItemTapped(int index, BuildContext context) {
  //   switch (index) {
  //     case 0:
  //       GoRouter.of(context).go('/list');
  //       break;
  //     case 1:
  //       GoRouter.of(context).go('/large-list');
  //       break;
  //     case 2:
  //       GoRouter.of(context).go('/list/detail');
  //       break;
  //   }
  // }
}
