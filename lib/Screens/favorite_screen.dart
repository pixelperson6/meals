import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

import '../widget/recipie_list_item.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  const FavoriteScreen(this.favoriteMeals, {super.key});

  @override
  Widget build(BuildContext context) {
    return favoriteMeals.isEmpty ? 
    const Center(
      child: Text('You dont have any favorite meals.'),
    )
    : ListView.builder(
      itemBuilder: (context, index) {
        return RecipieItem(
          meal: favoriteMeals[index],
        );
      },
      itemCount: favoriteMeals.length,
    );
  }
}
