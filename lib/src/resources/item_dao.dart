import 'dart:async';

import './database.dart';
import './../models/checkout_item.dart';

class ItemDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createItem(CheckoutItem item) async {
    final db = await dbProvider.database;
    var result = db!.insert(itemTABLE, item.toDatabaseJson());

    return result;
  }

  Future<List<CheckoutItem>> getItems({List<String>? columns}) async {
    final db = await dbProvider.database;

    final result = await db!.query(
      itemTABLE,
      columns: columns,
    );

    List<CheckoutItem> items = result.isNotEmpty 
      ? result.map((item) => CheckoutItem.fromDatabaseJson(item)).toList()
      : [];

    return items;
  }

  Future<int> updateItem(CheckoutItem item) async {
    final db = await dbProvider.database;
    final result = await db!.update(
      itemTABLE, 
      item.toDatabaseJson(),
    );

    return result;
  }

  Future<int> deleteItem(int id) async {
    final db = await dbProvider.database;
    final result = await db!.delete(
      itemTABLE, 
      where: 'id = ?',
      whereArgs: [id],
    );

    return result;
  }

  Future<int> deleteAllItems() async {
    final db = await dbProvider.database;
    final result = await db!.delete(itemTABLE);

    return result;
  }
}