import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/food.dart';
import '../repositories/ordersrepository.dart';

class FoodProvider extends StatelessWidget {
  final MyRepository repository;
  final List<Map<String, dynamic>> foodOrders;

  const FoodProvider({Key? key, required this.repository, required this.foodOrders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return FutureBuilder<List<Food>>(
      future: repository.getFoods(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return FoodList(foods: snapshot.data!, foodOrder: foodOrders,);
        } else {
          return Text('No data available');
        }
      },
    );
  }
}

class FoodList extends StatelessWidget {
  final List<Food> foods;
  final List<Map<String, dynamic>> foodOrder;

  const FoodList({Key? key, required this.foods, required this.foodOrder}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: foods.length,
      itemBuilder: (context, index) {
        final food = foods[index];
        final isOrdered = foodOrder.any((order) => order['name'] == food.name);
        return ListTile(
          title: Row(
            children: [
              Text(food.name),
              Spacer(),
              if (!isOrdered)
                GestureDetector(
                  onTap: () {
                    foodOrder.add({'name': food.name, 'price': food.price});
                  },
                  child: Icon(Icons.add),
                ),
            ],
          ),
          subtitle: Text('\$${food.price.toStringAsFixed(2)}'),
        );
      },
    );
  }
}