import 'package:ahwa/core/colors.dart';
import 'package:ahwa/models/reports_services.dart';
import 'package:flutter/material.dart';

class BestSellerDrink extends StatelessWidget {
  const BestSellerDrink({super.key, required this.report});
  final SalesReport report;

  @override
  Widget build(BuildContext context) {
    final sellers = report.topSellers;
    if (sellers.isEmpty) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Text('No sells yet'),
        ),
      );
    }

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 8,
              children: [
                Icon(Icons.local_fire_department, color: Colors.redAccent),
                Text(
                  'Best seller drink',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: sellers.entries.map((e) {
                return Chip(
                  avatar: Icon(
                    Icons.local_cafe,
                    size: 18,
                    color: MyColors().darkBrown,
                  ),
                  label: Text('${e.key} • x${e.value}'),
                  backgroundColor: MyColors().lightBrown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.brown.shade200),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
