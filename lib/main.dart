import 'package:flutter/material.dart';

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
      // Named routes
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

// Home Screen with navigation buttons
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              child: const Text('Go to Second Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/third',
                  arguments: 'Hello from Home Screen!',
                );
              },
              child: const Text('Go to Third Screen with Data'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const SecondScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = const Offset(0.0, 1.0);
                      var end = Offset.zero;
                      var curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: const Text('Go to Second Screen with Custom Animation'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/unknown');
              },
              child: const Text('Go to Unknown Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

// Second Screen
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go Back'),
        ),
      ),
    );
  }
}

// Third Screen that receives data
class ThirdScreen extends StatelessWidget {
  final String data;

  const ThirdScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Third Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Received Data: $data'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// Unknown Screen for undefined routes
class UnknownScreen extends StatelessWidget {
  const UnknownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('404 - Not Found')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go Back to Home'),
        ),
      ),
    );
  }
}
