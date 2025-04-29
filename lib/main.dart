import 'package:arrajewelry/constants/app_strings.dart';
import 'package:arrajewelry/data/app_data.dart';
import 'package:arrajewelry/views/widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:arrajewelry/views/pages/splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,
  );

  await AppData().loadProducts();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        fontFamily: 'SF Pro Display',
      ),
      // home: const LaunchDecider(),
      home: const WidgetTree(),
    );
  }
}

class LaunchDecider extends StatefulWidget {
  const LaunchDecider({super.key});

  @override
  State<LaunchDecider> createState() => _LaunchDeciderState();
}

class _LaunchDeciderState extends State<LaunchDecider> {
  bool _showSplash = false;

  @override
  void initState() {
    super.initState();
    _checkLastOpened();
  }

  Future<void> _checkLastOpened() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final lastOpenedMillis = prefs.getInt('last_opened');
    final firstLaunch = prefs.getBool('first_launch') ?? true;

    bool showSplash = false;

    if (firstLaunch) {
      showSplash = true;
      prefs.setBool('first_launch', false);
    } else if (lastOpenedMillis != null) {
      final lastOpened = DateTime.fromMicrosecondsSinceEpoch(lastOpenedMillis);
      final diff = now.difference(lastOpened).inDays;
      if (diff > 2) {
        showSplash = true;
      }
    }

    await prefs.setInt('last_opened', now.millisecondsSinceEpoch);

    setState(() {
      _showSplash = showSplash;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showSplash ? const Splash() : const WidgetTree();
  }
}
