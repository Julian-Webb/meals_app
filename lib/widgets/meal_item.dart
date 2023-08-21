import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    // required this.favoritedMeals,
    // required this.onToggleMealFavoriteStatus,
  });

  final Meal meal;
  // final List<Meal> favoritedMeals;
  // final Function(Meal meal) onToggleMealFavoriteStatus;

  // capitalize the first letter of the complexity
  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // gives the cards some distance from the edge and one another
      margin: const EdgeInsets.all(8),
      // should give the cards rounded borders
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      // this makes the prevent children to go out of boudaries of [Card]
      clipBehavior: Clip.hardEdge,
      // not sure what this does
      elevation: 2,
      child: InkWell(
        // on tap we show the meal details
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => MealDetailsScreen(
                meal: meal,
                // favoritedMeals: favoritedMeals,
                // onToggleMealFavoriteStatus: onToggleMealFavoriteStatus),
              ),
            ),
          );
        },
        // Stack can be used to position multiple widgets above each other
        child: Stack(
          // we start with the one on the bottom of the stack
          // (in the background)
          children: [
            // The Hero widget is used for animations accross different screens
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                // makes the image not be distorted but fit into the box
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            // [Positioned] let's us set where the child should be positioned
            // on the parent widget
            // left: 0 means no distance to the left border
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2, textAlign: TextAlign.center,
                      softWrap: true,
                      // tells us how text needs to be cut off it it's too long
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
