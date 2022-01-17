import 'dart:async';

import './item_dao.dart';
import './../models/checkout_item.dart';


class Repository {
  final itemDao = ItemDao();

  Future getAllItems() => itemDao.getItems();
  Future createItem(CheckoutItem item) => itemDao.createItem(item);
  Future updateItem(CheckoutItem item) => itemDao.updateItem(item);
  Future deleteItem(int id) => itemDao.deleteItem(id);
  Future deleteAllItems() => itemDao.deleteAllItems();
}