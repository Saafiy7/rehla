import 'package:flutter_test/flutter_test.dart';
import 'package:rehla/models/destination.dart';
import 'package:rehla/provider/favoris_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('restores two favorites after creating a new model', () async {
    const first = Destination(
      id: '1',
      nom: 'Sidi Bou Saïd',
      region: 'Tunis',
      categorie: 'Patrimoine',
      image: 'assets/images/sidi_bou_said.png',
      note: 4.9,
      prix: 180,
      duree: '1 jour',
      description: 'Village côtier',
    );
    const second = Destination(
      id: '2',
      nom: 'Djerba',
      region: 'Médenine',
      categorie: 'Plage',
      image: 'assets/images/djerba.png',
      note: 4.8,
      prix: 420,
      duree: '4 jours',
      description: 'Île méditerranéenne',
    );

    final runningModel = FavorisModel();
    await runningModel.basculer(first);
    await runningModel.basculer(second);

    final relaunchedModel = FavorisModel();
    await relaunchedModel.charger();

    expect(relaunchedModel.favorites, hasLength(2));
    expect(relaunchedModel.estFavori(first), isTrue);
    expect(relaunchedModel.estFavori(second), isTrue);
  });
}
