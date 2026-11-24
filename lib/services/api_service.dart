import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/api_config.dart';
import '../models/destination.dart';
import '../models/reservation.dart';

class ApiService {
  static const _cleCache = 'cache_destinations';
  static bool depuisCache = false;

  static Uri _url(String chemin) => Uri.parse('${ApiConfig.baseUrl}$chemin');

  static List<Destination> _decoder(String corps) =>
      (jsonDecode(corps) as List).map((e) => Destination.fromJson(e)).toList();

  static Future<List<Destination>> getDestinations() async {
    late String corps;
    late List<Destination> destinations;

    try {
      final reponse = await http
          .get(_url('/destinations'))
          .timeout(ApiConfig.timeout);
      if (reponse.statusCode != 200) {
        throw Exception('Erreur HTTP : ${reponse.statusCode}');
      }

      corps = utf8.decode(reponse.bodyBytes);
      destinations = _decoder(corps);
    } catch (e) {
      final prefs = await SharedPreferences.getInstance();
      final cache = prefs.getString(_cleCache);
      if (cache == null) {
        rethrow;
      }

      depuisCache = true;
      return _decoder(cache);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cleCache, corps);
    depuisCache = false;
    return destinations;
  }

  static Future<String> creerReservation(Reservation reservation) async {
    final reponse = await http
        .post(
          _url('/reservations'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(reservation.toJson()),
        )
        .timeout(ApiConfig.timeout);

    if (reponse.statusCode != 201) {
      throw Exception('Erreur HTTP : ${reponse.statusCode}');
    }

    final Map<String, dynamic> creee = jsonDecode(
      utf8.decode(reponse.bodyBytes),
    );
    return creee['id'].toString();
  }
}
