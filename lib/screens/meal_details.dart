import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_steps.dart';

/// A screen that displays the recipe, picture, etc. of a single meal
class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
    required this.favoritedMeals,
    required this.onToggleMealFavoriteStatus,
  });

  final Meal meal;
  final List<Meal> favoritedMeals;
  final Function(Meal meal) onToggleMealFavoriteStatus;

  @override
  State<StatefulWidget> createState() {
    return _MealDetailsScreenState();
  }
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // meal title in the app bar and below the meal image
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.meal.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.onToggleMealFavoriteStatus(widget.meal);
              setState(() {});
            },
            icon: Icon(widget.favoritedMeals.contains(widget.meal)
                ? Icons.star
                : Icons.star_border_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 14),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              children: widget.meal.ingredients
                  .map(
                    (ingredient) => Text(
                      ingredient,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            MealSteps(meal: widget.meal),
          ],
        ),
      ),
    );
  }
}
