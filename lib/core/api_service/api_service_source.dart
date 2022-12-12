import 'dart:convert';

import 'package:informat/core/exceptions/exception.dart';
import 'package:informat/core/firebase_services/data_model.dart';
import 'package:informat/feature/what_to_eat/domain/food_model.dart';
import 'package:http/http.dart';

class ApiServiceSource<T extends DataModel> {
  final String? apiId;
  final String? apiKey;
  final String baseUrl;
  ApiServiceSource({
    // required this.jsonChecker,
    required this.baseUrl,
    this.apiId,
    this.apiKey,
  });

  Future<List<FoodModel>> getReceipes({
    String? query,
    String? from,
    int? count,
    int? to,
  }) async {
    final url =
        '$baseUrl?api_key=${apiKey ?? ''}&api_id=${apiId ?? ''}&q=${query ?? ''}&from=${from ?? ''}&to=${to ?? ''}';

    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<FoodModel> recipes = [];

      for (final recipe in data) {
        recipes.add(FoodModel.fromJson(recipe));
      }

      return recipes;
    } else {
      throw ServerException('${response.statusCode}');
    }
  }

  // Future<FoodModel> viewReceipes() async {}
}
