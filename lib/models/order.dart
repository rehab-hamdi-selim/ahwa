import 'drinks.dart';

enum OrderStates { pending, completed }

class Order {
  final String orderId;
  final DateTime createdAt;
  final String customerName;
  final Drink drink;
  final String? instructions;
  final OrderStates orderState;

  Order({
    String? id,
    DateTime? createdAt,
    required this.customerName,
    required this.drink,
    this.instructions,
    this.orderState = OrderStates.pending,
  }) : orderId = id ?? DateTime.now().microsecondsSinceEpoch.toString(),
       createdAt = createdAt ?? DateTime.now();

  bool get isCompleted => orderState == OrderStates.completed;

  Order complete() => copyWith(orderState: OrderStates.completed);

  Order pending() => copyWith(orderState: OrderStates.pending);

  Order copyWith({
    String? customerName,
    Drink? drink,
    String? instructions,
    OrderStates? orderState,
    String? id,
    DateTime? createdAt,
  }) {
    return Order(
      id: id ?? orderId,
      createdAt: createdAt ?? this.createdAt,
      customerName: customerName ?? this.customerName,
      drink: drink ?? this.drink,
      instructions: instructions ?? this.instructions,
      orderState: orderState ?? this.orderState,
    );
  }
}
