import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

part 'model.g.dart';

// Global data
List<Place> places = [];

// Serialize model start
@JsonSerializable(explicitToJson: true)
class Place {
  final String title;
  final String location;
  final List<Tag> tags;
  final List<Delicious> delicious;

  Place({this.title, this.location, this.tags, this.delicious});
  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceToJson(this);

  /// Called on start. Load all data from shared_preference to global variable
  /// `places`.
  static initFromStorage() async {
    if (places.length != 0) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    for (String key in keys) {
      Map json = jsonDecode(prefs.getString(key));
      Place place = Place.fromJson(json);
      places.add(place);
    }

    return;
  }
}

@JsonSerializable()
class Delicious {
  final String name;
  final List<int> tagIndex;

  Delicious({this.name, this.tagIndex});
  factory Delicious.fromJson(Map<String, dynamic> json) =>
      _$DeliciousFromJson(json);
  Map<String, dynamic> toJson() => _$DeliciousToJson(this);
}

@JsonSerializable()
class Tag {
  final String text;
  final int counter;

  Tag({this.text, this.counter});
  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
  Map<String, dynamic> toJson() => _$TagToJson(this);
}
// Serialize model end
