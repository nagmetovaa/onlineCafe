import 'package:flutter/material.dart';

import '../../data/provider/BeverageProvider.dart';
import '../../data/provider/FoodProvider.dart';
import 'package:offlinecafe/src/data/repositories/ordersrepository.dart';

import '../widgets/custombutton.dart';
import 'orders.dart';

class CataloguePage extends StatelessWidget {

  final MyRepository myRepository = MyRepository();
  List<Map<String, dynamic>> orders = [];
  final String? deskName;

  CataloguePage({Key? key, this.deskName}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Food'),
              Tab(text: 'Beverage'),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 200,
                child: Text('Selected Desk: $deskName'),
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            // Содержимое для первой вкладки
            Container(
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                        child: FoodProvider(repository: myRepository, foodOrders: orders,),
                    ),
                    CustomButton(
                      text: 'Continue',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderPage(orders: orders, deskName: deskName),
                          ),
                        );
                      },
                    ),
                  ],
                )
              ),
            ),
            // Содержимое для второй вкладки
            Container(
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                        child: BeverageProvider(repository: myRepository, beverageOrders: orders,),
                    ),
                    CustomButton(
                      text: 'Continue',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderPage(orders: orders, deskName: deskName),
                          ),
                        );
                      },
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
