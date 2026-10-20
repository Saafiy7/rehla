import 'package:flutter/material.dart';
import 'package:rehla/widgets/home_header.dart';
import 'package:rehla/widgets/search_box.dart';
import '../widgets/hero_banner.dart';
import '../data/destinations.dart';
import '../widgets/destination_card.dart';
import '../widgets/section_title.dart';
import '../models/destination.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _categorie = 'Tout'; // l'état : la catégorie choisie

  List<Destination> get _filtrees {
    // TODO 1 : si _categorie vaut 'Tout', renvoyer destinations ;
    //          sinon, seulement celles dont categorie == _categorie
    //          (méthode where puis toList, vue en TP 2)
    if (_categorie == 'Tout') {
      return destinations;
    } else {
      return destinations
          .where((destination) => destination.categorie == _categorie)
          .toList();
    }
  }

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

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final c in categories)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(c),
                        selected: _categorie == c,
                        onSelected: (_) {
                          setState(() {
                            _categorie = c;
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const SizedBox(height: 20),

            SectionTitle(title: 'Populaires', action: 'Voir tout'),

            const SizedBox(height: 12),
            ...[
              for (final destination in _filtrees)
                DestinationCard(destination: destination),
            ],
          ],
        ),
      ),
    );
  }
}
