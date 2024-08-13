import 'package:flutter/material.dart';
import 'package:flutterroutes/screens/HomeScreen.dart';
import 'package:flutterroutes/screens/SecondScreen.dart';
import 'package:flutterroutes/screens/ThirdScreen.dart';
import 'package:flutterroutes/screens/UnknownScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Initial route
      initialRoute: '/',
      // Named routesz
      routes: {
        '/': (context) => const HomeScreen(),
        '/second': (context) => const SecondScreen(),
      },
      // Route generator for custom routing logic
      onGenerateRoute: (settings) {
        if (settings.name == '/third') {
          final args = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (context) {
              return ThirdScreen(data: args ?? 'No Data');
            },
          );
        }
        return null;
      },
      // Fallback route for undefined routes
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const UnknownScreen(),
        );
      },
    );
  }
}
