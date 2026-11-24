import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/favoris_model.dart';
import 'provider/reglages_model.dart';
import './screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FavorisModel()..charger(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReglagesModel()..charger(),
        ),
      ],
      child: const RihlaApp(),
    ),
  );
}

class RihlaApp extends StatelessWidget {
  const RihlaApp({super.key});

  @override
  Widget build(BuildContext context) {
    const graine = Color(0xFF0E7C86);
    final sombre = context.watch<ReglagesModel>().sombre;

    return MaterialApp(
      title: 'Rihla',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: graine),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: graine,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: sombre ? ThemeMode.dark : ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}
