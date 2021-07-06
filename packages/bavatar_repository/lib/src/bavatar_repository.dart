import 'dart:async';

import 'package:bavatar_api/bavatar_api.dart' hide Bavatar;
import 'package:bavatar_repository/bavatar_repository.dart';

class BavatarFailure implements Exception {}

class BavatarRepository {
  BavatarRepository({BavatarApiClient? bavatarApiClient})
      : _bavatarApiClient = bavatarApiClient ?? BavatarApiClient();

  final BavatarApiClient _bavatarApiClient;

  Future<List<Bavatar>> getBavatars() async {
    final bavatar = await _bavatarApiClient.getBavatars();
    return bavatar.data
        .map((e) => Bavatar(
              id: e.id,
              url: e.url,
              gender: e.gender,
              ageRange: e.ageRange,
              type: e.nature.toType,
              createdAt: e.createdAt,
              updatedAt: e.updatedAt,
            ))
        .toList();
  }
}

extension on BavatarNature {
  BavatarType get toType {
    switch (this) {
      case BavatarNature.casual:
        return BavatarType.casual;
      case BavatarNature.professional:
        return BavatarType.professional;
      default:
        return BavatarType.unknown;
    }
  }
}
