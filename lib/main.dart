import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackautomat_2502/config/supabase_config.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseKey,
  );
  debugPrint('Starting Vending Machine...');
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

/// Root widget that returns the screen
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
