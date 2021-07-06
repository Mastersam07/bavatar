// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bavatar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bavatar _$BavatarFromJson(Map<String, dynamic> json) {
  return Bavatar(
    id: json['id'] as int,
    url: json['url'] as String,
    gender: json['gender'] as String,
    ageRange: json['ageRange'] as String,
    type: _$enumDecode(_$BavatarTypeEnumMap, json['type']),
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );
}

Map<String, dynamic> _$BavatarToJson(Bavatar instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'gender': instance.gender,
      'ageRange': instance.ageRange,
      'type': _$BavatarTypeEnumMap[instance.type],
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
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

const _$BavatarTypeEnumMap = {
  BavatarType.casual: 'casual',
  BavatarType.professional: 'professional',
  BavatarType.unknown: 'unknown',
};
