import 'package:flutter/material.dart';
import 'package:meals/Screens/category_meals_screen.dart';
import 'package:meals/Screens/filters_screen.dart';
import 'package:meals/Screens/meal_detail_screen.dart';
import 'package:meals/Screens/tabs_screen.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/models/meal.dart';

import 'Screens/categories_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegeterian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritemeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegeterian']! && !meal.isVegetarian) {
          return false;
        }

        return true;

        //...
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoritemeals.indexWhere((element) => element.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoritemeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritemeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool isFavorite(String mealId) {
    return _favoritemeals.any((element) => element.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals',
      theme: ThemeData(
          // is not restarted.
          primarySwatch: Colors.pink,
          colorScheme: const ColorScheme.light(
            primary: Colors.pink,
            secondary: Colors.amber,
          ),
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyMedium: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodySmall: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                titleMedium: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RobotoCondensed'),
              )),
      //home: const CategoriesScreen(),
      // initialRoute: '/',
      routes: {
        TabsScreen.routeName: (context) => TabsScreen(_favoritemeals),
        CategoryMealScrenn.routeName: (context) =>
            CategoryMealScrenn(_availableMeals),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_toggleFavorite, isFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_setFilters, _filters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (context) => const CategoriesScreen());
      },
    );
  }
}
