import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class QuickProductTile extends StatelessWidget {
  final String name;
  final String unit;
  final String stock;
  final double price;
  final Color color;
  final VoidCallback? onAdd;

  const QuickProductTile({
    super.key,
    required this.name,
    required this.unit,
    required this.stock,
    required this.price,
    this.color = AppTheme.primary,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.shopping_bag, color: color),
          ),
          const Spacer(),
          Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            '$unit • Stock: $stock',
            style: TextStyle(color: AppTheme.muted, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Text(
            '\$${price.toStringAsFixed(0)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onAdd,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 8),
                backgroundColor: color,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Agregar'),
            ),
          ),
        ],
      ),
    );
  }
}
