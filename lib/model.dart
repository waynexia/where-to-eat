import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable(explicitToJson: true)
class Place {
  final String title;
  final String location;
  final List<Tag> tags;
  final List<Delicious> delicious;

  Place({this.title, this.location, this.tags, this.delicious});
  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceToJson(this);
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
