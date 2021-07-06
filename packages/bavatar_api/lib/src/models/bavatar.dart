import 'package:json_annotation/json_annotation.dart';

part 'bavatar.g.dart';

@JsonSerializable()
class BavatarModel {
  final bool error;
  final List<Bavatar> data;
  BavatarModel({
    required this.error,
    required this.data,
  });

  factory BavatarModel.fromJson(Map<String, dynamic> json) =>
      _$BavatarModelFromJson(json);

  Map<String, dynamic> toJson() => _$BavatarModelToJson(this);
}

enum BavatarNature {
  casual,
  professional,
  unknown,
}

@JsonSerializable()
class Bavatar {
  final int id;
  final String url;
  final String? name;
  final String? email;
  final String gender;
  @JsonKey(name: 'age_range')
  final String ageRange;
  final BavatarNature nature;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  Bavatar({
    this.name,
    this.email,
    required this.id,
    required this.url,
    required this.gender,
    required this.ageRange,
    required this.nature,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Bavatar.fromJson(Map<String, dynamic> json) =>
      _$BavatarFromJson(json);

  Map<String, dynamic> toJson() => _$BavatarToJson(this);
}
