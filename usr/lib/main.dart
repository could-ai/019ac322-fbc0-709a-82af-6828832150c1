import 'package:flutter/material.dart';
import 'package:couldai_user_app/screens/home_screen.dart';
import 'package:couldai_user_app/screens/dashboard_screen.dart';
import 'package:couldai_user_app/screens/editor_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CouldAI Video Subtitler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF0A2540),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF0A2540), // Dark Navy
          secondary: Color(0xFF42C2B3), // Turquoise Accent
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          background: Colors.white,
          surface: Color(0xFFF6F9FC), // Soft Gray
          onBackground: Color(0xFF32325D),
          onSurface: Color(0xFF32325D),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold, color: Color(0xFF0A2540)),
          displayMedium: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Color(0xFF0A2540)),
          headlineMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Color(0xFF0A2540)),
          bodyLarge: TextStyle(fontSize: 16.0, color: Color(0xFF525F7F)),
          bodyMedium: TextStyle(fontSize: 14.0, color: Color(0xFF525F7F)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF42C2B3), // Turquoise Accent
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/editor': (context) => const EditorScreen(),
      },
    );
  }
}
