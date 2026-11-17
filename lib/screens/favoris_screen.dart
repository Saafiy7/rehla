import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/favoris_model.dart';
import '../widgets/destination_card.dart';

class FavorisScreen extends StatelessWidget {
  const FavorisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoris = context.watch<FavorisModel>().liste;

    if (favoris.isEmpty) {
      return const Center(
        child: Text('Aucun favori pour le moment'),
      );
    }

    return ListView.builder(
      itemCount: favoris.length,
      itemBuilder: (context, index) =>
          DestinationCard(destination: favoris[index]),
    );
  }
}
