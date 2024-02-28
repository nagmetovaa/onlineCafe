import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/beverage.dart';
import '../models/food.dart';
import '../repositories/ordersrepository.dart';

class BeverageProvider extends StatelessWidget {
  final MyRepository repository;
  final List<Map<String, dynamic>> beverageOrders;

  const BeverageProvider({Key? key, required this.repository, required this.beverageOrders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Beverage>>(
      future: repository.getBeverage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return BeverageList(beverages: snapshot.data!, beverageOrder: beverageOrders,);
        } else {
          return Text('No data available');
        }
      },
    );
  }
}

class BeverageList extends StatelessWidget {
  final List<Beverage> beverages;
  final List<Map<String, dynamic>> beverageOrder;
  const BeverageList({Key? key, required this.beverages, required this.beverageOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: beverages.length,
      itemBuilder: (context, index) {
        final beverage = beverages[index];
        final isOrdered = beverageOrder.any((order) => order['name'] == beverage.name);
        return ListTile(
          title: Row(
            children: [
              Text(beverage.name),
              Spacer(),
              if (!isOrdered)
                GestureDetector(
                  onTap: () {
                    beverageOrder.add({'name': beverage.name, 'price': beverage.price});
                  },
                  child: Icon(Icons.add),
                ),
            ],
          ),
          subtitle: Text('\$${beverage.price.toStringAsFixed(2)}'),
        );
      },
    );
  }
}