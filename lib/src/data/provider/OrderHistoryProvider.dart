import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offlinecafe/src/data/models/order.history.dart';
import '../repositories/ordersrepository.dart';

class HistoryProvider extends StatelessWidget {
  final MyRepository repository;

  const HistoryProvider({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<History>>(
      future: repository.getBasketItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return HistoryList(history: snapshot.data!);
        } else {
          return Text('No data available');
        }
      },
    );
  }
}

class HistoryList extends StatelessWidget {
  final List<History> history;

  const HistoryList({Key? key, required this.history}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, index) {
        final his = history[index];
        return ListTile(
          title: Text(his.name),
          subtitle: Text(his.desk),
          onTap: () {
          },
        );
      },
    );
  }
}