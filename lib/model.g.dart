// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) {
  return Place(
    title: json['title'] as String,
    location: json['location'] as String,
    tags: (json['tags'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
    delicious: (json['delicious'] as List)
        ?.map((e) =>
            e == null ? null : Delicious.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'title': instance.title,
      'location': instance.location,
      'tags': instance.tags,
      'delicious': instance.delicious?.map((e) => e?.toJson())?.toList(),
    };

Delicious _$DeliciousFromJson(Map<String, dynamic> json) {
  return Delicious(
    name: json['name'] as String,
    tags: (json['tags'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
  );
}

Map<String, dynamic> _$DeliciousToJson(Delicious instance) => <String, dynamic>{
      'name': instance.name,
      'tags': instance.tags,
    };
