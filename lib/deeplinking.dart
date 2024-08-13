import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    ));

/********
     redirection url to check deeplink = Https://dhruvilborad.github.io/  or  Http://dhruvilborad.github.io/
 *********/
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('Home Screen')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // Navigate to the details screen
              context.go('/details');
            },
            child: const Text('Go to Details'),
          ),
        ),
      ),
      routes: [
        GoRoute(
          path: 'details',
          builder: (context, state) => Scaffold(
            appBar: AppBar(title: const Text('Details Screen')),
          ),
        ),
      ],
    ),
  ],
);
