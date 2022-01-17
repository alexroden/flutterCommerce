import 'dart:async';

import './../resources/repository.dart';
import './../models/checkout_item.dart';

class ItemBloc {
  final _repository = Repository();
  final _controller = StreamController<List<CheckoutItem>>.broadcast();

  get items => _controller.stream;

  ItemBloc() {
    getItems();
  }

  getItems() async {
    _controller.sink.add(await _repository.getAllItems());
  }

  createItem(CheckoutItem item) async {
    await _repository.createItem(item);
    getItems();
  }

  updateItem(CheckoutItem item) async {
    await _repository.updateItem(item);
    getItems();
  }

  deleteItem(int id) async {
    await _repository.deleteItem(id);
    getItems();
  }

  deleteAllItems() async {
    await _repository.deleteAllItems();
  }

  dispose() {
    _controller.close();
  }
}