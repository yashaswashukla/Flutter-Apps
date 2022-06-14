import 'package:flutter/material.dart';

import '../Models/meal.dart';
import '../Widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);
  @override
  State<CategoryMealsScreen> createState() => references();
}

class references extends State<CategoryMealsScreen> {
  // final String categoryId;
  String categoryTitle;
  List<Meal> displayedMeals;

  var _loadInitData = false;

  @override
  void initState() {
    // final routeArgs =
    //     ModalRoute.of(context).settings.arguments as Map<String, String>;
    // final categoryTitle = routeArgs['title'];
    // final categoryId = routeArgs['id'];
    // final categoryMeals = DUMMY_MEALS.where((meal) {
    //   return meal.categories.contains(categoryId);
    // }).toList();
    super.initState();
  }

  //This will be triggered when the references of the state will be changed.
  @override
  void didChangeDependencies() {
    if (!_loadInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
