import 'package:flutter/material.dart';
import 'package:offlinecafe/src/data/repositories/ordersrepository.dart';
import 'package:offlinecafe/src/presentation/widgets/custombutton.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final MyRepository repository = MyRepository();

  @override
  void initState() {
    super.initState();
    repository.open();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            CustomButton(
              text: 'Menu',
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/catalogue');
              },
            ),
            CustomButton(
              text: 'Desks',
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/desk');
              },
            ),
            CustomButton(
              text: 'Order History',
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/history');
              },
            )
          ],
        )
      ),
    );
  }
}