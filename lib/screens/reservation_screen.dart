import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // pour inputFormatters
import '../models/destination.dart';
import '../models/reservation.dart';

class ReservationScreen extends StatefulWidget {
  final Destination destination;
  final int voyageurs;
  const ReservationScreen({
    super.key,
    required this.destination,
    required this.voyageurs,
  });
  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _telCtrl = TextEditingController();

  @override
  void dispose() {
    // TODO 1 : libérer les trois contrôleurs, puis super.dispose()
    _nomCtrl.dispose();
    _emailCtrl.dispose();
    _telCtrl.dispose();
    super.dispose();
  }

  InputDecoration _deco(String label, IconData icone, {String? aide}) {
    return InputDecoration(
      labelText: label,
      helperText: aide,
      prefixIcon: Icon(icone),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  String? _validerNom(String? v) {
    if (v == null || v.trim().isEmpty) return 'Indiquez votre nom';
    if (v.trim().length < 3) return 'Au moins 3 caractères';
    return null;
  }

  String? _validerEmail(String? v) {
    // TODO 2 : vide -> "Indiquez votre e-mail"
    //          ne respecte pas RegExp(r'^[\w.+-]+@[\w-]+\.[\w.]+$')
    //          -> 'E-mail invalide (ex. : nom@mail.tn)'
    if (v == null || v.trim().isEmpty) return 'Indiquez votre e-mail';
    if (!RegExp(r'^[\w.+-]+@[\w-]+\.[\w.]+$').hasMatch(v))
      return 'E-mail invalide (ex. : nom@mail.tn)';
    return null;
  }

  String? _validerTel(String? v) {
    // TODO 3 : vide -> 'Indiquez votre téléphone'
    //          longueur différente de 8 -> '8 chiffres attendus'
    if (v == null || v.trim().isEmpty) return 'Indiquez votre téléphone';
    if (v.length != 8) return '8 chiffres attendus';
    return null;
  }

  void _valider() {
    if (!_formKey.currentState!.validate()) return;
    // Provisoire : sera remplacé au palier 5
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Formulaire valide')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Réserver')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TODO 4 : récapitulatif (image 64 x 64, nom, durée, voyageurs)
              const SizedBox(height: 24),
              TextFormField(
                controller: _nomCtrl,
                decoration: _deco('Nom complet', Icons.person_outline),
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                validator: _validerNom,
              ),
              const SizedBox(height: 16),
              // TODO 5 : champ E-mail (clavier emailAddress)
              TextFormField(
                controller: _emailCtrl,
                decoration: _deco('E-mail', Icons.email_outlined),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: _validerEmail,
              ),
              const SizedBox(height: 16),
              // TODO 6 : champ Téléphone (clavier phone, chiffres seulement,
              //          8 maximum, texte d'aide '8 chiffres, sans indicatif')
              TextFormField(
                controller: _telCtrl,
                decoration: _deco(
                  'Téléphone',
                  Icons.phone_outlined,
                  aide: '8 chiffres, sans indicatif',
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                validator: _validerTel,
              ),
            ],
          ),
        ),
      ),
      // TODO 7 : bottomNavigationBar avec un FilledButton.icon « Confirmer »
      //          qui appelle _valider (inspirez-vous de la barre du détail)
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: FilledButton.icon(
          onPressed: _valider,
          icon: const Icon(Icons.check),
          label: const Text('Confirmer'),
        ),
      ),
    );
  }
}
