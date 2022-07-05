import 'package:flutter/material.dart';
import 'package:resep_makanan/models/random_recipes_model.dart';
import 'package:resep_makanan/models/recipe_model.dart';
import 'package:resep_makanan/services/recipe_service.dart';

class RecipeProvider extends ChangeNotifier {
  final RecipeService _resepService = RecipeService();
  late List<Results> _recipeList;
  late RecipeModel? _recipeDetail;
  late bool _loading = true;

  bool get loading => _loading;
  List<Results> get recipeList => _recipeList;
  RecipeModel? get recipeDetail => _recipeDetail;

  RecipeProvider() {
    _fetchRecipes();
    notifyListeners();
  }

  _fetchRecipes() async {
    _recipeList = await _resepService.getRecipes();
    toggleLoading();
    notifyListeners();
  }

  fetchRecipe(int idRecipe) async {
    _recipeDetail = await _resepService.getRecipe(idRecipe);
    toggleLoading();
    notifyListeners();
  }

  toggleLoading() {
    _loading = !_loading;
    notifyListeners();
  }

  getRecipesCount() {
    return _recipeList.length;
  }
}
