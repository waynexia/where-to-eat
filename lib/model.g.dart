// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) {
  return Place(
    title: json['title'] as String,
    location: json['location'] as String,
    tags: (json['tags'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    delicious: (json['delicious'] as List)
        ?.map((e) =>
            e == null ? null : Delicious.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'title': instance.title,
      'location': instance.location,
      'tags': instance.tags?.map((e) => e?.toJson())?.toList(),
      'delicious': instance.delicious?.map((e) => e?.toJson())?.toList(),
    };

Delicious _$DeliciousFromJson(Map<String, dynamic> json) {
  return Delicious(
    name: json['name'] as String,
    tagIndex: (json['tagIndex'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$DeliciousToJson(Delicious instance) => <String, dynamic>{
      'name': instance.name,
      'tagIndex': instance.tagIndex,
    };

Tag _$TagFromJson(Map<String, dynamic> json) {
  return Tag(
    text: json['text'] as String,
    counter: json['counter'] as int,
  );
}

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'text': instance.text,
      'counter': instance.counter,
    };
