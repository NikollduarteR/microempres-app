import 'package:flutter/material.dart';
import 'package:microempresa/widgets/search_bar.dart';
import 'package:provider/provider.dart';

import '../presentation/providers/producto_provider.dart';
import '../themes/app_theme.dart';
import '../widgets/category_chips.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/section_header.dart';
import '../widgets/summary_card.dart';

class InventarioView extends StatefulWidget {
  const InventarioView({super.key});
  @override
  State<InventarioView> createState() => _InventarioViewState();
}

class _InventarioViewState extends State<InventarioView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ProductoProvider>();
      provider.loadProductos();
    });
  }

  int selectedCategory = 0;
  final categories = [
    'Todos',
    'Frutas',
    'Verduras',
    'Carnes',
    'Arroz',
    'Otros',
  ];

  final lowStockProducts = [
    {'name': 'Azúcar morena', 'stock': '4 und', 'min': '10 und'},
    {'name': 'Café molido', 'stock': '2 und', 'min': '6 und'},
    {'name': 'Aceite vegetal 1L', 'stock': '8 und', 'min': '12 und'},
  ];

  final movements = [
    {
      'type': 'Entrada',
      'item': 'Arroz premium',
      'qty': '+45 und',
      'date': '08:45',
    },
    {
      'type': 'Salida',
      'item': 'Manzana royal',
      'qty': '-12 Kg',
      'date': '09:10',
    },
    {
      'type': 'Ajuste',
      'item': 'Huevos AA',
      'qty': '-2 cubetas',
      'date': '09:45',
    },
  ];

  List<Map<String, dynamic>> get _inventoryStats => [
    {
      'label': 'SKU activos',
      'value': '152',
      'helper': '8 sin stock',
      'icon': Icons.view_list_outlined,
      'color': AppTheme.primary,
    },
    {
      'label': 'Valorización',
      'value': '\$ 12.4 M',
      'helper': '+4% semanal',
      'icon': Icons.attach_money,
      'color': Colors.green,
    },
    {
      'label': 'Rotación',
      'value': '23 días',
      'helper': 'Objetivo: 20 días',
      'icon': Icons.autorenew,
      'color': Colors.orange,
    },
    {
      'label': 'Alertas',
      'value': '6 productos',
      'helper': 'Revisar hoy',
      'icon': Icons.warning_amber,
      'color': Colors.redAccent,
    },
  ];

  Widget _buildSummary(BoxConstraints constraints) {
    final isWide = constraints.maxWidth > 600;
    final width = isWide ? constraints.maxWidth / 2 - 12 : constraints.maxWidth;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _inventoryStats
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Inventario',
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.qr_code_scanner),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          SearchBarWidget(hint: 'Buscar producto o código...'),
          const SizedBox(height: 10),
          CategoryChips(
            categories: categories,
            selectedIndex: selectedCategory,
            onTap: (i) => setState(() => selectedCategory = i),
          ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) {
              return _buildSummary(constraints);
            },
          ),
          const SizedBox(height: 12),
          SectionHeader(
            title: 'Alertas de stock',
            subtitle: 'Productos por debajo del mínimo',
            actionText: 'Ver todos',
            onAction: () {},
            icon: Icons.warning_amber_rounded,
          ),
          ...lowStockProducts.map(
            (product) => Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.redAccent.withValues(alpha: 0.15),
                  child: const Icon(Icons.inventory_2, color: Colors.redAccent),
                ),
                title: Text(product['name']!),
                subtitle: Text(
                  'Actual: ${product['stock']} • Mínimo: ${product['min']}',
                ),
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text('Reponer'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Consumer<ProductoProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading && provider.productos.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (provider.hasError) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    provider.errorMessage ?? 'Error al cargar productos',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              if (provider.productos.isEmpty) {
                return const SizedBox.shrink();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    title: 'Productos',
                    subtitle: 'Listado en inventario desde la API',
                    icon: Icons.inventory_2_outlined,
                  ),
                  ...provider.productos.map(
                    (producto) => Card(
                      child: ListTile(
                        leading: const Icon(Icons.inventory_2),
                        title: Text(producto.nombre),
                        subtitle: Text(
                          'Stock: ${producto.stock ?? 0} • Precio: ${producto.precioDeVenta ?? 0}',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              );
            },
          ),
          const SectionHeader(
            title: 'Movimientos recientes',
            subtitle: 'Últimas entradas, salidas y ajustes',
            icon: Icons.sync_alt,
          ),
          Card(
            child: Column(
              children: movements
                  .map(
                    (movement) => ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        child: Icon(
                          movement['type'] == 'Entrada'
                              ? Icons.call_received
                              : movement['type'] == 'Salida'
                              ? Icons.call_made
                              : Icons.tune,
                          color: movement['type'] == 'Entrada'
                              ? Colors.green
                              : movement['type'] == 'Salida'
                              ? Colors.redAccent
                              : Colors.orange,
                        ),
                      ),
                      title: Text(movement['item']!),
                      subtitle: Text(
                        '${movement['type']} • ${movement['date']}',
                      ),
                      trailing: Text(
                        movement['qty']!,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(
            title: 'Tareas de inventario',
            subtitle: 'Organiza tus pendientes',
            icon: Icons.check_circle_outline,
          ),
          Card(
            child: Column(
              children: const [
                ListTile(
                  leading: Icon(
                    Icons.assignment_outlined,
                    color: AppTheme.primary,
                  ),
                  title: Text('Conteo cíclico - Abarrotes'),
                  subtitle: Text('Programado para hoy 4:00 p.m.'),
                  trailing: Icon(Icons.chevron_right),
                ),
                Divider(height: 0),
                ListTile(
                  leading: Icon(Icons.inventory, color: Colors.orange),
                  title: Text('Actualizar costos importados'),
                  subtitle: Text('Última actualización: 3 días'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final provider = context.read<ProductoProvider>();
          provider.loadProductos();
        },
        icon: const Icon(Icons.add),
        label: const Text('Nuevo producto'),
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
    );
  }
}
