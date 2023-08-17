import 'package:flutter/material.dart';
// import 'package:meals_app/screens/tabs.dart';
// import 'package:meals_app/widgets/main_drawer.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<StatefulWidget> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  // var _glutenFreeFilterSet = false;
  // var _lactoseFreeFilterSet = false;
  // var _vegetarianFilterSet = false;
  // var _veganFilterSet = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
  //   _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
  //   _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
  //   _veganFilterSet = widget.currentFilters[Filter.vegan]!;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'meals') {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (ctx) => const TabsScreen(),
      //         ),
      //       );
      //     }
      //   },
      // ),
      body: Column(
        children: [
          SwitchListTile(
            value: widget.currentFilters[Filter.glutenFree]!,
            onChanged: (isChecked) => {
              setState(() {
                widget.currentFilters[Filter.glutenFree] = isChecked;
              })
            },
            title: Text(
              'Gluten-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include gluten-free meals.',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.onBackground,
            contentPadding: const EdgeInsets.only(
              left: 34,
              right: 22,
            ),
          ),
          SwitchListTile(
            value: widget.currentFilters[Filter.lactoseFree]!,
            onChanged: (isChecked) => {
              setState(() {
                widget.currentFilters[Filter.lactoseFree] = isChecked;
              })
            },
            title: Text(
              'Lactose-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include lactose-free meals.',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.onBackground,
            contentPadding: const EdgeInsets.only(
              left: 34,
              right: 22,
            ),
          ),
          SwitchListTile(
            value: widget.currentFilters[Filter.vegetarian]!,
            onChanged: (isChecked) => {
              setState(() {
                widget.currentFilters[Filter.vegetarian] = isChecked;
              })
            },
            title: Text(
              'Vegetarian',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include vegetarian meals.',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.onBackground,
            contentPadding: const EdgeInsets.only(
              left: 34,
              right: 22,
            ),
          ),
          SwitchListTile(
            value: widget.currentFilters[Filter.vegan]!,
            onChanged: (isChecked) => {
              setState(() {
                widget.currentFilters[Filter.vegan] = isChecked;
              })
            },
            title: Text(
              'Vegan',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include vegan meals.',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.onBackground,
            contentPadding: const EdgeInsets.only(
              left: 34,
              right: 22,
            ),
          ),
        ],
      ),
    );
  }
}
