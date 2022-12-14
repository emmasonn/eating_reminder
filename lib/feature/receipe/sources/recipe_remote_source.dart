import 'dart:convert';

import 'package:informat/core/helpers/json_checker.dart';
import 'package:informat/feature/receipe/model/recipe_model.dart';
import 'package:http/http.dart' as http;

abstract class RecipeRemoteSource {
  Future<APIRecipeQuery> getRecipes({required params});
}

class RecipeRemoteSourceImpl extends RecipeRemoteSource {
  final http.Client client;
  final JsonChecker jsonChecker;

  RecipeRemoteSourceImpl({
    required this.client,
    required this.jsonChecker,
  });

  @override
  Future<APIRecipeQuery> getRecipes({
    required params,
  }) async {
    
    final url = '';

    final response =
        await client.get(Uri.parse(url)).timeout(const Duration(seconds: 25));
    
    //parse the respone
    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);
      return APIRecipeQuery.fromJson(data);
    } else {
      throw const FormatException();
    }
  }
}
