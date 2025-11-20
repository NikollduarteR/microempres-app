import 'package:flutter/material.dart';
import 'package:microempresa/widgets/search_bar.dart';

import '../themes/app_theme.dart';
import '../widgets/category_chips.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/product_card.dart';
import '../widgets/section_header.dart';
import '../widgets/summary_card.dart';

class VentasView extends StatefulWidget {
  const VentasView({super.key});
  @override
  State<VentasView> createState() => _VentasViewState();
}

class _VentasViewState extends State<VentasView> {
  int selectedCategory = 0;
  final categories = ['Todos', 'Frutas', 'Verduras', 'Carnes'];
  final cartItems = [
    {'name': 'Manzana roja', 'qty': 2, 'price': 12000},
    {'name': 'Arroz premium 500g', 'qty': 1, 'price': 14500},
    {'name': 'Aceite vegetal 1L', 'qty': 1, 'price': 18500},
  ];

  List<Map<String, dynamic>> get _saleStats => [
    {
      'label': 'Ventas hoy',
      'value': '\$ 865.000',
      'helper': '12 tickets',
      'icon': Icons.today,
      'color': Colors.green,
    },
    {
      'label': 'Ticket promedio',
      'value': '\$ 72.100',
      'helper': '+5% semanal',
      'icon': Icons.stacked_bar_chart,
      'color': AppTheme.primary,
    },
  ];

  double get subtotal => cartItems.fold(
    0,
    (sum, item) => sum + (item['price'] as int) * (item['qty'] as int),
  );

  Widget _buildCartCard() {
    final tax = subtotal * 0.19;
    final total = subtotal + tax;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen de venta',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            ...cartItems.map(
              (item) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(item['name'] as String),
                subtitle: Text('Cantidad: ${item['qty']}'),
                trailing: Text(
                  '\$${(item['price'] as int) * (item['qty'] as int)}',
                ),
              ),
            ),
            const Divider(),
            _totalsRow('Subtotal', subtotal),
            _totalsRow('IVA (19%)', tax),
            const SizedBox(height: 8),
            _totalsRow('Total', total, bold: true),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              children: [
                ActionChip(
                  avatar: const Icon(Icons.credit_card, size: 16),
                  onPressed: () {},
                  label: const Text('Pago tarjeta'),
                ),
                ActionChip(
                  avatar: const Icon(Icons.money, size: 16),
                  onPressed: () {},
                  label: const Text('Pago en efectivo'),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Guardar borrador'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.point_of_sale),
                    label: const Text('Finalizar venta'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _totalsRow(String label, double value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          Text(
            '\$${value.toStringAsFixed(0)}',
            style: TextStyle(
              fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
              fontSize: bold ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Ventas',
        trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.history)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          SearchBarWidget(hint: 'Buscar ítems o escanear código'),
          const SizedBox(height: 10),
          CategoryChips(
            categories: categories,
            selectedIndex: selectedCategory,
            onTap: (i) => setState(() => selectedCategory = i),
          ),
          const SizedBox(height: 6),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600;
              final width = isWide
                  ? constraints.maxWidth / 2 - 12
                  : constraints.maxWidth;
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _saleStats
                    .map(
                      (stat) => SizedBox(
                        width: width,
                        child: SummaryCard(
                          label: stat['label'],
                          value: stat['value'],
                          helper: stat['helper'],
                          icon: stat['icon'],
                          color: stat['color'],
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 12),
          const SectionHeader(
            title: 'Catálogo rápido',
            subtitle: 'Productos filtrados por categoría',
            icon: Icons.storefront,
          ),
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
                price: '\$${(10 + i) * 3}.000',
                onTap: () {},
              );
            },
          ),
          const SizedBox(height: 12),
          _buildCartCard(),
          const SizedBox(height: 24),
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
