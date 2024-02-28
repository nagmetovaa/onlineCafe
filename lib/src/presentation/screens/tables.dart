import 'package:flutter/material.dart';
import '../../data/provider/DeskProvider.dart';
import '../../data/repositories/ordersrepository.dart';
import 'catalogue.dart';

class DeskDropdown extends StatefulWidget {


  @override
  _DeskDropdownState createState() => _DeskDropdownState();
}

class _DeskDropdownState extends State<DeskDropdown> {
  String? _selectedDesk;
  final List<Map<String, dynamic>> desks = [
    {'name':'table1'}, {'name':'table2'}, {'name':'table3'}, {'name':'table4'}, {'name':'table5'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Заказы'),
        ),
      body: SizedBox(
        width: 100,
        child: ListView.builder(
          itemCount: desks.length,
          itemBuilder: (context, index) {
            var desk = desks[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CataloguePage(deskName: desk['name'])),
                );
              },
              child: Card(
                child: ListTile(
                  title: Text(desk['name'] as String),
                  subtitle: Icon(Icons.table_bar),
                ),
              ),
            );
          }
        )
      )
    );
  }
}
class NextPage extends StatelessWidget {
  final String? deskName;

  NextPage({Key? key, this.deskName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Text('Selected Desk: $deskName'),
      ),
    );
  }
}