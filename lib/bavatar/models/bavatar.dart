import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:bavatar_repository/bavatar_repository.dart' hide Bavatar;
import 'package:bavatar_repository/bavatar_repository.dart'
    as bavatar_repository;

part 'bavatar.g.dart';

@JsonSerializable()
class Bavatar extends Equatable {
  const Bavatar({
    required this.id,
    required this.url,
    required this.gender,
    required this.ageRange,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Bavatar.fromJson(Map<String, dynamic> json) =>
      _$BavatarFromJson(json);

  factory Bavatar.fromRepository(bavatar_repository.Bavatar bavatar) {
    return Bavatar(
      id: bavatar.id,
      url: bavatar.url,
      gender: bavatar.gender,
      ageRange: bavatar.ageRange,
      type: bavatar.type,
      createdAt: bavatar.createdAt,
      updatedAt: bavatar.updatedAt,
    );
  }

  static final empty = Bavatar(
    id: 0,
    url: '',
    gender: '',
    ageRange: '',
    type: BavatarType.unknown,
    createdAt: DateTime(0),
    updatedAt: DateTime(0),
  );

  final int id;
  final String url;
  final String gender;
  final String ageRange;
  final BavatarType type;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object> get props {
    return [
      id,
      url,
      gender,
      ageRange,
      type,
      createdAt,
      updatedAt,
    ];
  }

  Map<String, dynamic> toJson() => _$BavatarToJson(this);
}
