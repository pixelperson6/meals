import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widget/recipie_list_item.dart';

class CategoryMealScrenn extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  const CategoryMealScrenn(this.availableMeals, {super.key});

  @override
  State<CategoryMealScrenn> createState() => _CategoryMealScrennState();
}

class _CategoryMealScrennState extends State<CategoryMealScrenn> {
  String categoryTitle = '';

  List<Meal> categoryMeals = List.empty();

  bool isChangeDone = false;

  @override
  void didChangeDependencies() {
    if (!isChangeDone) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;

      categoryTitle = routeArgs['title'].toString();
      final categoryId = routeArgs['id'].toString();

      categoryMeals = widget.availableMeals
          .where(((element) => element.categories.contains(categoryId)))
          .toList();
      isChangeDone = true;
    }

    super.didChangeDependencies();
  }

  // void _removeMeal(String id) {
  //   setState(() {
  //     categoryMeals.removeWhere((element) => element.id == id);
  //   });
  // }

  // final String categoryId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return RecipieItem(
            meal: categoryMeals[index],
            //handleResult: _removeMeal,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
