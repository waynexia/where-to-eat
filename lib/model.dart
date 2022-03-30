import 'dart:collection';

import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

part 'model.g.dart';

// Global data
List<Place> places = [];

// Serialize model start
@JsonSerializable(explicitToJson: true)
class Place {
  String title;
  String location;
  Map<String, int> tags;
  List<Delicious> delicious;

  Place({this.title, this.location, this.tags, this.delicious});
  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceToJson(this);

  /// Called on start. Load all data from shared_preference to global variable
  /// `places`.
  static initFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (places.length != 0) {
      places.clear();
    }
    final keys = prefs.getKeys();

    for (String key in keys) {
      Map json = jsonDecode(prefs.getString(key));
      Place place = Place.fromJson(json);
      places.add(place);
    }

    return;
  }

  static Place defaultValue() {
    return Place(tags: {}, delicious: []);
  }
}

@JsonSerializable()
class Delicious {
  String name;
  Map<String, int> tags;

  Delicious({this.name, this.tags});
  factory Delicious.fromJson(Map<String, dynamic> json) =>
      _$DeliciousFromJson(json);
  Map<String, dynamic> toJson() => _$DeliciousToJson(this);

  static Delicious defaultValue() {
    return Delicious(tags: {});
  }
}
// Serialize model end
