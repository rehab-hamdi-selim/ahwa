import 'package:ahwa/models/order_store.dart';
import 'package:ahwa/models/reports_services.dart';
import 'package:ahwa/presentation/widgets/best_seller.dart';
import 'package:ahwa/presentation/widgets/stat_card.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});
  final store = OrdersStore();
  late final ReportService service = ReportService(store);

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final report = service.generateDailyReport(today);
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Report')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  color: Colors.teal.shade600,
                  icon: Icons.done_all,
                  title: 'Completed',
                  value: '${report.totalCompleted}',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  color: Colors.brown.shade700,
                  icon: Icons.payments,
                  title: 'Revenue (EGP)',
                  value: report.totalRevenue.toStringAsFixed(0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          BestSellerDrink(report: report),
        ],
      ),
    );
  }
}
