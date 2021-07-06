import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bavatar_api/bavatar_api.dart';

/// Exception thrown when getBavatars fails.
class BavatarRequestFailure implements Exception {}

/// Exception thrown when no bavatar is found.
class BavatarNotFoundFailure implements Exception {}

/// {@template bavatar_api_client}
/// Dart API Client which wraps the [Bavatar API](https://bavatar.herokuapp.com/api/avatar).
/// {@endtemplate}
class BavatarApiClient {
  /// {@macro bavatar_api_client}
  BavatarApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'bavatar.herokuapp.com';
  final http.Client _httpClient;

  /// Fetches all [BavatarModel] from `/api/avatar`.
  Future<BavatarModel> getBavatars() async {
    final weatherRequest = Uri.https(_baseUrl, '/api/avatar');
    final weatherResponse = await _httpClient.get(weatherRequest);

    if (weatherResponse.statusCode != 200) {
      throw BavatarRequestFailure();
    }

    final bodyJson = jsonDecode(weatherResponse.body) as Map<String, dynamic>;

    if (bodyJson.isEmpty) {
      throw BavatarNotFoundFailure();
    }

    final dataJson = bodyJson['data'] as List;

    if (dataJson.isEmpty) {
      throw BavatarNotFoundFailure();
    }

    return BavatarModel.fromJson(bodyJson);
  }
}
