import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bavatar.g.dart';

enum BavatarType {
  casual,
  professional,
  unknown,
}

@JsonSerializable()
class Bavatar extends Equatable {
  Bavatar({
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

  Map<String, dynamic> toJson() => _$BavatarToJson(this);

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
}
