import 'order.dart';
import 'order_store.dart';

class SalesReport {
  final DateTime date;
  final int totalCompleted;
  final double totalRevenue;
  final Map<String, int> topSellers;

  const SalesReport({
    required this.date,
    required this.totalCompleted,
    required this.totalRevenue,
    required this.topSellers,
  });
}

class ReportService {
  final OrdersStore _store;
  ReportService(this._store);

  List<Order> _completedForDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    final all = _store.current;
    return all
        .where(
          (o) =>
              o.isCompleted &&
              o.createdAt.isAfter(start) &&
              o.createdAt.isBefore(end),
        )
        .toList(growable: false);
  }

  SalesReport generateDailyReport(DateTime day) {
    final list = _completedForDay(day);

    final totalRevenue = list.fold<double>(
      0.0,
      (sum, o) => sum + o.drink.price,
    );

    final counts = <String, int>{};
    for (final o in list) {
      counts.update(o.drink.name, (v) => v + 1, ifAbsent: () => 1);
    }
    if (counts.isEmpty) {
      return SalesReport(
        date: DateTime(day.year, day.month, day.day),
        totalCompleted: 0,
        totalRevenue: 0.0,
        topSellers: const {},
      );
    }

    final maxCount = counts.values.reduce((a, b) => a > b ? a : b);

    final filteredTop = <String, int>{
      for (final e in counts.entries)
        if (e.value == maxCount) e.key: e.value,
    };

    return SalesReport(
      date: DateTime(day.year, day.month, day.day),
      totalCompleted: list.length,
      totalRevenue: totalRevenue,
      topSellers: filteredTop,
    );
  }
}
