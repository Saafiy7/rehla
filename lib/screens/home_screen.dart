import 'package:flutter/material.dart';
import 'package:rehla/widgets/home_header.dart';
import 'package:rehla/widgets/search_box.dart';
import '../widgets/hero_banner.dart';
import '../data/destinations.dart';
import '../widgets/destination_card.dart';
import '../widgets/section_title.dart';

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

            const SizedBox(height: 24),
            HeroBanner(destination: destinations.first),

            const SectionTitle(title: 'Categories'),

            const SizedBox(height: 20),

            SectionTitle(title: 'Populaires', action: 'Voir tout'),

            const SizedBox(height: 12),
            ...[
              for (final destination in destinations)
                DestinationCard(destination: destination),
            ],
          ],
        ),
      ),
    );
  }
}
