import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    // required this.favoritedMeals,
    // required this.onToggleMealFavoriteStatus,
    required this.availableMeals,
  });

  // final List<Meal> favoritedMeals;
  // final Function(Meal meal) onToggleMealFavoriteStatus;
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    // Find the meals that belong to this category
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // let's us navigate to a different screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          // favoritedMeals: favoritedMeals,
          // onToggleMealFavoriteStatus: onToggleMealFavoriteStatus,
        ),
      ),
    );
    // equivalent:
    // Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      // [gridDelegate] controls the layout of the [GridView] items
      // [SliverGridDelegateWithFixedCrossAxisCount] lets us specify the
      // number of columns
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: (Category category) {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}
