import 'package:flutter/material.dart';

import '../../data/provider/OrderHistoryProvider.dart';
import '../../data/repositories/ordersrepository.dart';
import '../widgets/custombutton.dart';

class OrderHistoryPage extends StatelessWidget {


  final MyRepository myRepository = MyRepository();
  // OrderHistoryPage({Key? key, required this.orders, this.deskName}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History Page'),
      ),
      body: Center(
          child: Column(
            children: [
              Expanded(
                child: HistoryProvider(repository: myRepository,),
              ),
            ],
          )
      ),
    );
  }
}
