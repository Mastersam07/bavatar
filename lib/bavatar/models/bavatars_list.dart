import 'package:bavatar/bavatar/models/bavatar.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:bavatar_repository/bavatar_repository.dart'
    as bavatar_repository;

part 'bavatars_list.g.dart';

@JsonSerializable()
class BavatarsList extends Equatable {
  const BavatarsList({
    required this.bavatars,
  });

  factory BavatarsList.fromJson(Map<String, dynamic> json) =>
      _$BavatarsListFromJson(json);

  factory BavatarsList.fromRepository(
      List<bavatar_repository.Bavatar> bavatars) {
    return BavatarsList(
      bavatars: bavatars
          .map((e) => Bavatar(
                id: e.id,
                url: e.url,
                gender: e.gender,
                ageRange: e.ageRange,
                type: e.type,
                createdAt: e.createdAt,
                updatedAt: e.updatedAt,
              ))
          .toList(),
    );
  }

  static const empty = BavatarsList(bavatars: []);

  final List<Bavatar> bavatars;

  @override
  List<Object> get props {
    return [bavatars];
  }

  Map<String, dynamic> toJson() => _$BavatarsListToJson(this);
}
