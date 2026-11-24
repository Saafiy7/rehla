import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/destination.dart';

class FavorisModel extends ChangeNotifier {
  // cspell:ignore favoris
  static const _cle = 'favoris';
  final Map<String, Destination> _favoris = {};

  List<Destination> get favorites => _favoris.values.toList();

  bool estFavori(Destination destination) =>
      _favoris.containsKey(destination.id);

  Future<void> charger() async {
    final prefs = await SharedPreferences.getInstance();
    // TODO 1 : lire la liste de textes (liste vide si rien n'est stocké)
    final listeTextes = prefs.getStringList(_cle) ?? [];
    // TODO 2 : pour chaque texte : jsonDecode puis Destination.fromJson,
    //          ranger la destination dans _favoris avec son id
    for (final texte in listeTextes) {
      final map = jsonDecode(texte);
      final destination = Destination.fromJson(map);
      _favoris[destination.id] = destination;
    }
    notifyListeners();
  }

  Future<void> _sauvegarder() async {
    final prefs = await SharedPreferences.getInstance();
    // TODO 3 : transformer chaque destination en texte
    //          (toJson puis jsonEncode) et l'écrire avec setStringList
    final listeTextes = _favoris.values
        .map((destination) => jsonEncode(destination.toJson()))
        .toList();
    await prefs.setStringList(_cle, listeTextes);
  }

  Future<bool> basculer(Destination d) async {
    final ajoute = _favoris.remove(d.id) == null;
    if (ajoute) _favoris[d.id] = d;
    notifyListeners();
    await _sauvegarder(); // TP7 : recopie sur le disque
    return ajoute;
  }
}
