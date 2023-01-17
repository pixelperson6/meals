import 'package:flutter/material.dart';
import 'package:meals/widget/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filter_screen';

  final Function saveFilters;
  final Map<String, bool> currentFilter;

  const FiltersScreen(this.saveFilters, this.currentFilter, {super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilter['gluten']!;

    _lactoseFree = widget.currentFilter['lactose']!;

    _vegan = widget.currentFilter['vegan']!;

    _vegetarian = widget.currentFilter['vegeterian']!;

    super.initState();
  }

  Widget buildSwitchListTIle(
      String title, String disc, bool currentValue, Function updateValue) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(disc),
        value: currentValue,
        onChanged: (value) => updateValue(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filter!'),
        actions: [
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegeterian': _vegetarian,
                };
                widget.saveFilters(selectedFilters);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Adjust your meal Selection.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Expanded(
            child: ListView(
          children: [
            buildSwitchListTIle(
                'Gluten-Free', 'Only include gluten-free meals', _glutenFree,
                (newvalue) {
              setState(() {
                _glutenFree = newvalue;
              });
            }),
            buildSwitchListTIle(
                'Lactose-Free', 'Only include lactose-free meals', _lactoseFree,
                (newvalue) {
              setState(() {
                _lactoseFree = newvalue;
              });
            }),
            buildSwitchListTIle('Vegan', 'Only include vegan meals', _vegan,
                (newvalue) {
              setState(() {
                _vegan = newvalue;
              });
            }),
            buildSwitchListTIle(
                'Vegeterian', 'Only include vegeterian meals', _vegetarian,
                (newvalue) {
              setState(() {
                _vegetarian = newvalue;
              });
            }),
          ],
        ))
      ]),
    );
  }
}
