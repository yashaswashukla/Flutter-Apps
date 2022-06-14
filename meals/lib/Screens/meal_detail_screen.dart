import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  final Function toggleFav;
  final Function isMealFavorite;
  MealDetailScreen(this.toggleFav, this.isMealFavorite);

  static const routeName = '/meal-details';

  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget buildContainer(Widget child, double height) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        // color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      height: height,
      width: 320,
      child: child,
    );
  }

  Widget buildIngredientView(List<String> selectedItems) {
    return ListView.builder(
      itemBuilder: (ctx, index) => Card(
        color: Colors.purple[50],
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text(
            selectedItems[index],
          ),
        ),
      ),
      itemCount: selectedItems.length,
    );
  }

  Widget buildStepView(List<String> selectedItems) {
    return ListView.builder(
      itemBuilder: (ctx, index) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text('${(index + 1)}'),
            ),
            title: Text(
              selectedItems[index],
            ),
          ),
          Divider(),
        ],
      ),
      itemCount: selectedItems.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => mealId == meal.id);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(buildIngredientView(selectedMeal.ingredients), 150),
            buildSectionTitle(context, 'Steps'),
            buildContainer(buildStepView(selectedMeal.steps), 300),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isMealFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () {
          toggleFav(mealId);
        },
      ),
    );
  }
}
