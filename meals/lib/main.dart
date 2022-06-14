import 'package:flutter/material.dart';

import './Screens/category_meals_screen.dart';
import './Screens/categories_screen.dart';
import './Screens/meal_detail_screen.dart';
import './Screens/tabs_screen.dart';
import './Screens/filters_screen.dart';
import './dummy_data.dart';
import './Models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _favoriteMeals = [];

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  void _setFilters(Map<String, bool> filteredData) {
    setState(() {
      _filters = filteredData;
      _availableMeals = DUMMY_MEALS.where(
        (meal) {
          if (_filters['gluten'] && !meal.isGlutenFree) {
            return false;
          }
          if (_filters['lactose'] && !meal.isLactoseFree) {
            return false;
          }
          if (_filters['vegetarian'] && !meal.isVegetarian) {
            return false;
          }
          if (_filters['vegan'] && !meal.isVegan) {
            return false;
          }
          return true;
        },
      ).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    //This checks if that particular element is the part of the list or not and gives back the index
    //Now if the any element with mealId is present in the favorite meals list then we will get it's index
    //And then we will remove it, but if the index==-1 which means that the element is not present in the list then
    //we will add that element in the list
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool isMealFavorite(mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.amber,
        canvasColor: Color.fromARGB(255, 251, 250, 237),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyLarge: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyMedium: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            titleLarge: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, isMealFavorite),
        FilterScreen.routeName: (ctx) => FilterScreen(_filters, _setFilters),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(
      //     builder: (ctx) => CategoriesScreen(),
      //   );

      //FallBack, shown if unknown route is accessed

      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
    );
  }
}
