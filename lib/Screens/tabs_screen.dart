import 'package:flutter/material.dart';
import 'package:meals/Screens/categories_screen.dart';
import 'package:meals/Screens/favorite_screen.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widget/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/';

  final List<Meal> favoriteMeals;

  const TabsScreen(this.favoriteMeals, {super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages = List.empty();

  @override
  void initState() {
    _pages = [
      {'page': const CategoriesScreen(), 'title': 'Categories'},
      {'page': FavoriteScreen(widget.favoriteMeals), 'title': 'Your favorite'},
    ];

    super.initState();
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'].toString()),
      ),
      drawer: const MainDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          // type: BottomNavigationBarType.shifting,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
              //  backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              //  backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            )
          ]),
    );
  }
}
