// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bavatar_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BavatarState _$BavatarStateFromJson(Map<String, dynamic> json) {
  return BavatarState(
    status: _$enumDecode(_$BavatarStatusEnumMap, json['status']),
    bavatarsList: json['bavatarsList'] == null
        ? null
        : BavatarsList.fromJson(json['bavatarsList'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BavatarStateToJson(BavatarState instance) =>
    <String, dynamic>{
      'status': _$BavatarStatusEnumMap[instance.status],
      'bavatarsList': instance.bavatarsList.toJson(),
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

const _$BavatarStatusEnumMap = {
  BavatarStatus.initial: 'initial',
  BavatarStatus.loading: 'loading',
  BavatarStatus.success: 'success',
  BavatarStatus.failure: 'failure',
};
