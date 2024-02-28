import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../repositories/ordersrepository.dart';

class DeskProvider extends StatelessWidget {
  final MyRepository repository;

  const DeskProvider({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: repository.loadDesks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return DeskDropdown(desks: snapshot.data!);
        } else {
          return Text('No desk data available');
        }
      },
    );
  }
}

class DeskDropdown extends StatefulWidget {
  final List<Map<String, dynamic>> desks;

  const DeskDropdown({Key? key, required this.desks}) : super(key: key);

  @override
  _DeskDropdownState createState() => _DeskDropdownState();
}

class _DeskDropdownState extends State<DeskDropdown> {
  String? _selectedDesk;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedDesk,
      items: widget.desks.map<DropdownMenuItem<String>>((desk) {
        return DropdownMenuItem<String>(
          value: desk['name'] as String,
          child: Card(
            child: ListTile(
              title: Text(desk['name'] as String),
              onTap: () {
                setState(() {
                  _selectedDesk = desk['name'] as String;
                });
              },
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedDesk = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Select a desk',
        border: OutlineInputBorder(),
      ),
    );
  }
}
