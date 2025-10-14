import 'package:flutter/material.dart';
import 'package:microempresa/widgets/search_bar.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/category_chips.dart';
import '../widgets/product_card.dart';

class VentasView extends StatefulWidget {
  const VentasView({super.key});
  @override
  State<VentasView> createState() => _VentasViewState();
}

class _VentasViewState extends State<VentasView> {
  int selectedCategory = 0;
  final categories = ['Todos', 'Frutas', 'Verduras', 'Carnes'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Ventas'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: SearchBarWidget(hint: 'Buscar ítems...'),
          ),
          CategoryChips(
            categories: categories,
            selectedIndex: selectedCategory,
            onTap: (i) => setState(() => selectedCategory = i),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.9,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: 6,
              itemBuilder: (context, i) {
                return ProductCard(
                  name: [
                    'Manzana',
                    'Cebolla',
                    'Plátano',
                    'Carne',
                    'Arroz',
                    'Leche',
                  ][i],
                  subtitle: '1 Kg - Stock: ${30 - i}',
                  price: '\$${(10 + i) * 3}.00',
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.point_of_sale),
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 2),
    );
  }
}
