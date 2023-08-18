import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    // required this.favoritedMeals,
    // required this.onToggleMealFavoriteStatus,
  });

  final String? title;
  final List<Meal> meals;
  // final List<Meal> favoritedMeals;
  // final Function(Meal meal) onToggleMealFavoriteStatus;

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Nothing to show here!',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors
                      .white, // Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );
    const Text('No Meals in this category.');

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          // favoritedMeals: favoriteMeals,
          // onToggleMealFavoriteStatus: onToggleMealFavoriteStatus,
        ),
      );
    }

    // return without Scaffold is title == null, else return with Scaffold
    // This is done so that we have the option of not displaying an app bar
    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
