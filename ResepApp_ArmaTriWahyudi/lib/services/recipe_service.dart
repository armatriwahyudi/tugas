import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:resep_makanan/models/random_recipes_model.dart';
import 'package:resep_makanan/models/recipe_model.dart';
import 'package:resep_makanan/static/static_values.dart';

class RecipeService {
  Future<List<Results>> getRecipes() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://$kApiURLDomain/$kApiEndPointRecipes?apiKey=$kApiKey'),
      );

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        return RandomRecipesModel.fromJson(parsed).results!;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception('Failed to get the recipes: $e');
    }
  }

  Future<RecipeModel?> getRecipe(int idRecipe) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://$kApiURLDomain/$kApiEndPointRecipe/$idRecipe/information?apiKey=$kApiKey'),
      );

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        return RecipeModel.fromJson(parsed);
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception('Failed to get the recipes: $e');
    }
  }
}
