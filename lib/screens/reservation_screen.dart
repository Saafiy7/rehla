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
    if (!_formKey.currentState!.validate()) {
      setState(() => _autoValidation = AutovalidateMode.onUserInteraction);
      return;
    }
    // Provisoire : sera remplacé au palier 5
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Formulaire valide')));
  }

  final _dateCtrl = TextEditingController();
  DateTime? _date; // null tant qu'aucune date n'est choisie
  String _formule = 'Essentiel';
  bool _conditions = false;
  AutovalidateMode _autoValidation = AutovalidateMode.disabled;

  int get _prixParPersonne => _formule == 'Confort'
      ? (widget.destination.prix * 1.3).round()
      : widget.destination.prix;

  int get _total => _prixParPersonne * widget.voyageurs;

  Future<void> _choisirDate() async {
    final demain = DateTime.now().add(const Duration(days: 1));
    final choisie = await showDatePicker(
      context: context,
      initialDate: _date ?? demain,
      firstDate: demain,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: 'Date de départ',
    );
    // TODO 1 : si l'utilisateur annule (null), ne rien faire
    if (choisie == null) return;
    // TODO 2 : avec setState, mémoriser la date dans _date et écrire
    //          'jj/mm/aaaa' dans _dateCtrl.text (padLeft(2, '0'))
    setState(() {
      _date = choisie;
      _dateCtrl.text =
          '${choisie.day.toString().padLeft(2, '0')}/${choisie.month.toString().padLeft(2, '0')}/${choisie.year}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Réserver')),
      body: Form(
        key: _formKey,
        autovalidateMode: _autoValidation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TODO 4 : récapitulatif (image 64 x 64, nom, durée, voyageurs)
              const SizedBox(height: 24),
              TextFormField(
                controller: _dateCtrl,
                readOnly: true,
                onTap: _choisirDate,
                decoration: _deco(
                  'Date de départ',
                  Icons.calendar_month_outlined,
                ),
                validator: (_) => _date == null ? 'Choisissez une date' : null,
              ),
              const SizedBox(height: 16),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(
                    value: 'Essentiel',
                    label: Text('Essentiel'),
                    icon: Icon(Icons.backpack_outlined),
                  ),
                  ButtonSegment(
                    value: 'Confort',
                    label: Text('Confort +30 %'),
                    icon: Icon(Icons.hotel_outlined),
                  ),
                ],
                selected: {_formule},
                onSelectionChanged: (choix) {
                  // memoriser le choix dans _formule avec setState
                  setState(() => _formule = choix.first);
                },
              ),
              CheckboxListTile(
                value: _conditions,
                onChanged: (v) => setState(() => _conditions = v ?? false),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                title: const Text("J'accepte les conditions d'annulation"),
                subtitle: const Text('Annulation gratuite jusqu\'à 48 h avant'),
              ),
              const SizedBox(height: 16),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '$_prixParPersonne DT × ${widget.voyageurs}',
              textAlign: TextAlign.end,
            ),
            Text(
              '$_total DT',
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _conditions ? _valider : null,
              icon: const Icon(Icons.check),
              label: const Text('Confirmer'),
            ),
          ],
        ),
      ),
    );
  }
}
