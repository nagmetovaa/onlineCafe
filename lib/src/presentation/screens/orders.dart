import 'package:flutter/material.dart';

import '../../data/repositories/ordersrepository.dart';
import '../widgets/custombutton.dart';
import 'mainscreen.dart';

class OrderPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders;
  final String? deskName;

  final MyRepository myRepository = MyRepository();
  OrderPage({Key? key, required this.orders, this.deskName}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Desk Name: $deskName', style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),),
          DataTable(
            columns: [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Price')),
            ],
            rows: orders.map<DataRow>((order) {
              return DataRow(
                cells: [
                  DataCell(Text(order['name'].toString())),
                  DataCell(Text(order['price'].toString())),
                ],
              );
            }).toList(),
          ),
          CustomButton(
            text: 'Order',
            onPressed: () async {
              for (var order in orders) {
                await myRepository.insertBasketItem(order['name'], deskName!, order['price']);
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(),
                ),
              );
              print('Orders added to basket successfully.');
            },
          ),
        ],
      ),
    );
  }
}
