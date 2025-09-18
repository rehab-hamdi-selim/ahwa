import 'package:ahwa/core/colors.dart';
import 'package:ahwa/models/order.dart';
import 'package:ahwa/models/order_store.dart';
import 'package:ahwa/presentation/screens/reports_screen.dart';
import 'package:ahwa/presentation/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'new_order_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final store = OrdersStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => const NewOrderScreen()),
              );
            },
            child: const Text(
              '+ new Order',
              style: TextStyle(color: Colors.green),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            tooltip: 'Daily Report',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ReportScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ValueListenableBuilder<List<Order>>(
          valueListenable: store.orders,
          builder: (context, orders, _) {
            final pendingOrdersList = orders
                .where((o) => !o.isCompleted)
                .toList();
            final completedOrdersList = orders
                .where((o) => o.isCompleted)
                .toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pending Orders
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pending Orders',
                        style: TextStyle(
                          color: MyColors().darkBrown,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: pendingOrdersList.isEmpty
                              ? const Center(
                                  child: Text('There are no pending orders'),
                                )
                              : ListView.separated(
                                  itemCount: pendingOrdersList.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 10),
                                  itemBuilder: (context, index) {
                                    final order = pendingOrdersList[index];
                                    return OrderItem(
                                      key: ValueKey(order.orderId),
                                      order: order,
                                      onToggleCompleted: (checked) {
                                        store.toggleCompleted(
                                          order.orderId,
                                          checked,
                                        );
                                      },
                                    );
                                  },
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Completed Orders
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Completed (today)',
                        style: TextStyle(
                          color: MyColors().darkBrown,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: completedOrdersList.isEmpty
                              ? const Center(
                                  child: Text('No orders completed yet'),
                                )
                              : ListView.separated(
                                  itemCount: completedOrdersList.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 10),
                                  itemBuilder: (_, i) {
                                    final o = completedOrdersList[i];
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: Colors.brown),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 5.0,
                                          horizontal: 10,
                                        ),
                                        child: Text(
                                          '${o.drink.name} • ${o.drink.price} EGP',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
