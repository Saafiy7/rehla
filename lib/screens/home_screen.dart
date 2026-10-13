import 'package:flutter/material.dart';
import 'package:rehla/widgets/home_header.dart';
import 'package:rehla/widgets/search_box.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const HomeHeader(prenom: 'Youssef'),
            const SizedBox(height: 20),
            const SearchBox(),
          ],
        ),
      ),
    );
  }
}
