import 'dart:collection';
import 'package:flutter/material.dart';
import 'order.dart';

class OrdersStore {
  // Singleton via factory: أي استدعاء لـ OrdersStore() يرجّع نفس النسخة
  OrdersStore._();
  static final OrdersStore _instance = OrdersStore._();
  factory OrdersStore() => _instance;

  final ValueNotifier<List<Order>> orders = ValueNotifier<List<Order>>([]);

  UnmodifiableListView<Order> get current => UnmodifiableListView(orders.value);

  void add(Order order) {
    orders.value = [...orders.value, order];
  }

  void toggleCompleted(String id, bool completed) {
    orders.value = orders.value.map((o) {
      if (o.orderId != id) return o;
      return completed ? o.complete() : o.pending();
    }).toList();
  }

  List<Order> get pending => orders.value.where((o) => !o.isCompleted).toList();

  List<Order> get completed =>
      orders.value.where((o) => o.isCompleted).toList();
}
