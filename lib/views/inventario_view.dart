import 'package:flutter/material.dart';
import 'package:microempresa/widgets/search_bar.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/category_chips.dart';
import '../widgets/product_card.dart';

class InventarioView extends StatefulWidget {
  const InventarioView({super.key});
  @override
  State<InventarioView> createState() => _InventarioViewState();
}

class _InventarioViewState extends State<InventarioView> {
  int selectedCategory = 0;
  final categories = [
    'Todos',
    'Frutas',
    'Verduras',
    'Carnes',
    'Arroz',
    'Otros',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Inventario'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: SearchBarWidget(hint: 'Buscar producto...'),
          ),
          CategoryChips(
            categories: categories,
            selectedIndex: selectedCategory,
            onTap: (i) => setState(() => selectedCategory = i),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              itemCount: 8,
              itemBuilder: (context, i) => ProductCard(
                name: 'Producto ${i + 1}',
                subtitle: 'Stock: ${20 + i} - ${i % 2 == 0 ? "Kg" : "Und"}',
                price: '\$${(10 + i) * 2}.00',
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
    );
  }
}
