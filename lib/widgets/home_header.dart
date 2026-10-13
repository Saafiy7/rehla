import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String prenom;

  const HomeHeader({super.key, required this.prenom});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme; // la palette Material 3 du thème

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TODO 1 : Text 'Ahlan, $prenom 👋'
              //          style : bodyLarge, couleur cs.onSurfaceVariant
              Text(
                'Ahlan, $prenom 👋',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              // TODO 2 : Text "Où partez-vous\naujourd'hui ?"
              //          style : headlineSmall en gras
              Text(
                "Où partez-vous\naujourd'hui ?",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // TODO 3 : CircleAvatar de rayon 26, fond cs.primaryContainer,
        //          qui affiche l'initiale prenom[0] en gras, taille 22
        CircleAvatar(
          radius: 26,
          backgroundColor: cs.primaryContainer,
          child: Text(
            prenom[0],
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ],
    );
  }
}
