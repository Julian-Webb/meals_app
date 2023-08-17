import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

/// Displays the steps of the recipe to make the meal
class MealSteps extends StatelessWidget {
  const MealSteps({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    List<Padding> steps = [];

    meal.steps.asMap().forEach((index, step) {
      steps.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 2, 20, 2),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                child: Text(
                  '$index.',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Flexible(
                child: Text(
                  step,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                  softWrap: true,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps,
    );
  }
}
