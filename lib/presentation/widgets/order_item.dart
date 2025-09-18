import 'package:ahwa/models/order.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.order, this.onToggleCompleted});

  final Order order;
  final ValueChanged<bool>? onToggleCompleted;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(order.orderId),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text(
                  order.customerName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "${order.drink.name} • ${order.drink.price.toStringAsFixed(0)} EGP",
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  order.instructions ?? "",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            Checkbox(
              value: order.isCompleted,
              onChanged: (checked) {
                onToggleCompleted?.call(checked ?? false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
