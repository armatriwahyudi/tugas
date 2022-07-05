import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resep_makanan/providers/recipe_provider.dart';
import 'package:resep_makanan/screens/recipe_detail_screen.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resep Masakan'),
      ),
      body: Consumer<RecipeProvider>(
        builder: (context, recipeProvider, child) {
          return recipeProvider.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(32.0),
                  itemCount: recipeProvider.getRecipesCount(),
                  itemBuilder: (context, index) {
                    return Card(
                      child: GestureDetector(
                        onTap: () {
                          navigateDetailScreen(recipeProvider,
                              recipeProvider.recipeList[index].id!);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RecipeDetailScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Image.network(
                                recipeProvider.recipeList[index].image!,
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                recipeProvider.recipeList[index].title!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 10.0,
                  ),
                );
        },
      ),
    );
  }

  navigateDetailScreen(RecipeProvider recipeProvider, int recipeId) async {
    recipeProvider.toggleLoading();
    await recipeProvider.fetchRecipe(recipeId);
  }
}
