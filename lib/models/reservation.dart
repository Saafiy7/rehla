import 'destination.dart';

class Reservation {
  final String? id;   // NOUVEAU : null tant que le serveur ne l'a pas enregistrée
  final Destination destination;
  final String nom;
  final String email;
  final String telephone;
  final int voyageurs;
  final String formule;
  final DateTime dateDepart;
  final double total;
  const Reservation({ this.id, required this.destination, required this.nom, required this.email, required this.telephone, required this.voyageurs, required this.formule, required this.dateDepart, required this.total });
 
  Map<String, dynamic> toJson() {
    return {
      'destinationId': destination.id,   // l'id suffit
      'nom': nom,
      // TODO 1 : email, telephone, voyageurs, formule, total 
      'email': email,
      'telephone': telephone,
      'voyageurs': voyageurs,
      'formule': formule,
      'total': total,

      // TODO 2 : dateDepart -> texte avec toIso8601String()
      'dateDepart': dateDepart.toIso8601String(),
    };
  }
}

