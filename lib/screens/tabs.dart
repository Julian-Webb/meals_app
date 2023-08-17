import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  /// 0 = categories and 1 = favorites
  int _selectedPageIndex = 0;
  List<Meal> favoritedMeals = [];

  final Map<Filter, bool> _selectedFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  /// This is used to mark or unmark a meal as favorite. It add the meal to or
  /// removes it from [favoritedMeals].
  void _onToggleMealFavoriteStatus(Meal meal) {
    setState(() {
      if (favoritedMeals.contains(meal)) {
        favoritedMeals.remove(meal);
        _showInfoMessage('Meal removed from favorites');
      } else {
        favoritedMeals.add(meal);
        _showInfoMessage('Meal added to favorites');
      }
    });
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) {
    // Close the drawer
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage;
    String activePageTitle;

    if (_selectedPageIndex == 0) {
      activePage = CategoriesScreen(
        favoritedMeals: favoritedMeals,
        onToggleMealFavoriteStatus: _onToggleMealFavoriteStatus,
        availableMeals: availableMeals,
      );
      activePageTitle = 'Categories';
    } else if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: favoritedMeals,
        favoritedMeals: favoritedMeals,
        onToggleMealFavoriteStatus: _onToggleMealFavoriteStatus,
      );
      activePageTitle = 'Favorites';
    } else {
      throw Exception("_selectedPageIndex isn't 0 or 1");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
