import 'package:coffee_online_store/model/models/triple_value_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:latlong2/latlong.dart';

class TutorialValue {
  final List<String> _listIcons = [
    'assets/pics/coffee (0).png',
    'assets/pics/coffee (1).png',
    'assets/pics/coffee (2).png'
  ];

  final List<String> _listTitles;
  final List<String> _listContents;

  late final List<TripleValue> _listValue;

  TutorialValue(AppLocalizations localization)
      : _listTitles = [
          localization.flavorOfLifeTitle,
          localization.drinkOfMemoryTitle,
          localization.startWithACoffeeTitle,
        ],
        _listContents = [
          localization.flavorOfLife,
          localization.drinkOfMemory,
          localization.startWithACoffee,
        ] {
    _listValue = [
      TripleValue(a: _listIcons[0], b: _listTitles[0], c: _listContents[0]),
      TripleValue(a: _listIcons[1], b: _listTitles[1], c: _listContents[1]),
      TripleValue(a: _listIcons[2], b: _listTitles[2], c: _listContents[2]),
    ];
  }

  List<TripleValue> get() => _listValue;
}

const String urlEmptyHolder = 'assets/pics/image-gallery.png';
const String urlErrorHolder = 'assets/pics/broken-image.png';

class MapValue {
  final LatLng shopPosition = const LatLng(51.509865, -0.118092);

  MapValue();
}

class AuthValue {
  final int resendTime = 5;

  AuthValue();
}
