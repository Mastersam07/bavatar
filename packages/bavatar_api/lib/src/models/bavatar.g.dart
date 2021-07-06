// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bavatar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BavatarModel _$BavatarModelFromJson(Map<String, dynamic> json) {
  return BavatarModel(
    error: json['error'] as bool,
    data: (json['data'] as List<dynamic>)
        .map((e) => Bavatar.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BavatarModelToJson(BavatarModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'data': instance.data.map((e) => e.toJson()),
    };

Bavatar _$BavatarFromJson(Map<String, dynamic> json) {
  return Bavatar(
    name: json['name'] as String?,
    email: json['email'] as String?,
    id: json['id'] as int,
    url: json['url'] as String,
    gender: json['gender'] as String,
    ageRange: json['age_range'] as String,
    nature: _$enumDecode(_$BavatarNatureEnumMap, json['nature']),
    createdAt: DateTime.parse(json['created_at'] as String),
    updatedAt: DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$BavatarToJson(Bavatar instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'name': instance.name,
      'email': instance.email,
      'gender': instance.gender,
      'age_range': instance.ageRange,
      'nature': _$BavatarNatureEnumMap[instance.nature],
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$BavatarNatureEnumMap = {
  BavatarNature.casual: 'casual',
  BavatarNature.professional: 'professional',
  BavatarNature.unknown: 'unknown',
};
