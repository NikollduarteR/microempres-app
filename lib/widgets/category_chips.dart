import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class CategoryChips extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int>? onTap;
  const CategoryChips({
    super.key,
    required this.categories,
    this.selectedIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, i) {
          final selected = i == selectedIndex;
          return GestureDetector(
            onTap: () => onTap?.call(i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: selected ? AppTheme.primary : Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: selected
                    ? [BoxShadow(color: Colors.black12, blurRadius: 6)]
                    : null,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: selected ? Colors.white : Colors.grey[100],
                    child: Icon(
                      Icons.local_grocery_store,
                      color: selected ? AppTheme.primary : AppTheme.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    categories[i],
                    style: TextStyle(
                      color: selected ? Colors.white : AppTheme.muted,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemCount: categories.length,
      ),
    );
  }
}
