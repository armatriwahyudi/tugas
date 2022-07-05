import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:resep_makanan/providers/recipe_provider.dart';

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({Key? key}) : super(key: key);

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
              : recipeProvider.recipeDetail == null
                  ? const Center(
                      child: Text('Error!'),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32.0,
                          vertical: 20.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              recipeProvider.recipeDetail!.title!,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28.0,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Image.network(
                              recipeProvider.recipeDetail!.image!,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            const Text(
                              "Summary",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Html(
                              data: recipeProvider.recipeDetail!.summary!,
                              style: {
                                "*": Style(
                                  fontSize: const FontSize(16.0),
                                  margin: const EdgeInsets.all(0),
                                )
                              },
                            ),
                          ],
                        ),
                      ),
                    );
        },
      ),
    );
  }
}
