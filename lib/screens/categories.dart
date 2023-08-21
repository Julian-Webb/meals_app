import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

// [SingleTickerProviderStateMixin] if there's only one animationController
// [TickerProviderStateMixin] if there are multiple
class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  // late tells dart that this will have a value when it's used for the first
  // time but not yet when the class is created
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      // vsync tells us the framerate of the animation
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      // you animate between these two values
      lowerBound: 0,
      upperBound: 1,
    );

    // this start the animation
    // .forward() makes it play once
    // .repeat() makes it play repeatedly
    // .stop() stops it
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    // Find the meals that belong to this category
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // let's us navigate to a different screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
    // equivalent:
    // Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    // builder is called for every tick of the animation (60/sec)
    return AnimatedBuilder(
        animation: _animationController,
        // the child here should be anything that is not animated itself
        child: GridView(
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
        ),
        builder: (context, child) => SlideTransition(
              position: Tween(
                begin: const Offset(0, 0.3),
                end: const Offset(0, 0),
              ).animate(
                CurvedAnimation(
                  parent: _animationController,
                  // Curves.easeInOut makes the animation slow at the end and
                  // beginning
                  curve: Curves.easeInOut,
                ),
              ),
              // // .drive is used to create an animation based on another value
              // // here, it let's us translate the values from 0 to 1 to offsets
              // position: _animationController.drive(
              //   // Tween comes from between
              //   Tween(
              //     begin: const Offset(0, 0.3),
              //     end: const Offset(0, 0),
              //   ),
              // ),
              child: child,
            )
        // Padding(
        //   padding: EdgeInsets.only(top: 100 - _animationController.value * 100),
        //   child: child,
        // ),
        );
  }
}
