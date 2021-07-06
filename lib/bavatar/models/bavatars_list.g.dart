// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bavatars_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BavatarsList _$BavatarsListFromJson(Map<String, dynamic> json) {
  return BavatarsList(
    bavatars: (json['bavatars'] as List<dynamic>)
        .map((e) => Bavatar.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BavatarsListToJson(BavatarsList instance) =>
    <String, dynamic>{
      'bavatars': instance.bavatars,
    };
