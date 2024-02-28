import 'package:flutter/material.dart';
import 'package:offlinecafe/src/data/models/food.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/beverage.dart';
import '../models/order.history.dart';

class MyRepository {
  late Database _database;

  Future<void> open() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'cafe.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await createTables(db);
        await insertInitialData(db);
      },
    );
  }

  Future<void> createTables(Database db) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS food_ref(id INTEGER PRIMARY KEY, name TEXT, price REAL)',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS beverage_ref(id INTEGER PRIMARY KEY, name TEXT, price REAL)',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS basket(id INTEGER PRIMARY KEY, name TEXT, desk TEXT, price REAL)',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS desk(id INTEGER PRIMARY KEY, name TEXT)',
    );
  }

  Future<void> insertInitialData(Database db) async {
    await db.execute(
      'INSERT INTO food_ref(name, price) VALUES("meat", 50),("salad", 20),("steak", 60),("fish", 70),("seafoods", 100),("snack", 10)',
    );
    await db.execute(
      'INSERT INTO beverage_ref(name, price) VALUES("tea", 15),("coffee", 20),("juice", 10), ("lemonade", 7), ("wine", 25), ("water", 5)',
    );
    await db.execute(
      'INSERT INTO desk(name) VALUES("table1"),("table2"),("table3"), ("table4"), ("table5")',
    );
  }


  Future<List<Food>> getFoods() async {
    final Database db = await openDatabase('cafe.db');
    final List<Map<String, dynamic>> foodData = await db.rawQuery('SELECT * FROM food_ref');
    final List<Food> foodList = foodData.map((food) => Food.fromMap(food)).toList();
    return foodList;
  }

  Future<List<Beverage>> getBeverage() async {
    final Database db = await openDatabase('cafe.db');
    final List<Map<String, dynamic>> beverageData = await db.rawQuery('SELECT * FROM beverage_ref');
    final List<Beverage> beverageList = beverageData.map((beverage) => Beverage.fromMap(beverage)).toList();
    return beverageList;
  }

  Future<List<History>> getBasketItems() async {
    final Database db = await openDatabase('cafe.db');
    final List<Map<String, dynamic>> historyData = await db.rawQuery('SELECT * FROM basket');
    final List<History> historyList = historyData.map((history) => History.fromMap(history)).toList();
    return historyList;
  }

  Future<void> insertBasketItem(String name, String desk, double price) async {
    final Database db = await openDatabase('cafe.db');
    await db.insert(
      'basket',
      {
        'name': name,
        'desk': desk,
        'price': price,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> loadDesks() async {
    final Database db = await openDatabase('cafe.db');
    final List<Map<String, dynamic>> desks = await db.rawQuery('SELECT * FROM desk');
    return desks;
  }
}
