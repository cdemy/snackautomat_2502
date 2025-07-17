import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackautomat_2502/screens/main_screen.dart';
import 'package:snackautomat_2502/theme/vending_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// void main() {
//   debugPrint('Hello');
//   runApp(
//     const ProviderScope(
//       child: MyApp(),
//     ),
//   );
// }

const supabaseUrl = 'https://jdbfqgmiaayicsbhvihx.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpkYmZxZ21pYWF5aWNzYmh2aWh4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI1MTU5NjQsImV4cCI6MjA2ODA5MTk2NH0.Mu73oIrO4jsFFdNk3jnWLB_HZT8AmVCuyf8MTVP9Pqk';

Future<void> main() async {
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

/// Root widget taht returns the screen
class MyApp extends StatelessWidget {
  /// Regular constructor
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vending Machine App',
      theme: lightVendingMachineTheme,
      home: const MainScreen(),
    );
  }
}
