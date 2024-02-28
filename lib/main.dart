import 'package:flutter/material.dart';
import 'package:offlinecafe/src/presentation/screens/catalogue.dart';
import 'package:offlinecafe/src/presentation/screens/mainscreen.dart';
import 'package:offlinecafe/src/presentation/screens/orderHistory.dart';
import 'package:offlinecafe/src/presentation/screens/tables.dart';

void main()  {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.green,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/catalogue': (context) => CataloguePage(),
        '/desk': (context) => DeskDropdown(),
        '/history': (context) => OrderHistoryPage(),
      },
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
