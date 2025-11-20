import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../themes/app_theme.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/section_header.dart';
import '../widgets/summary_card.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  List<Map<String, dynamic>> get _mainStats => [
    {
      'title': 'Ventas del día',
      'value': '\$ 865.000',
      'helper': '+12% vs ayer',
      'icon': Icons.point_of_sale,
      'color': Colors.green,
    },
    {
      'title': 'Pedidos abiertos',
      'value': '18',
      'helper': '5 pendientes de pago',
      'icon': Icons.receipt_long,
      'color': Colors.orange,
    },
    {
      'title': 'Inventario valorizado',
      'value': '\$ 12.4 M',
      'helper': '6 productos sin stock',
      'icon': Icons.inventory_2,
      'color': AppTheme.primary,
    },
    {
      'title': 'Clientes activos',
      'value': '234',
      'helper': '+8 nuevos esta semana',
      'icon': Icons.people_alt,
      'color': Colors.blueAccent,
    },
  ];

  List<Map<String, dynamic>> get _recentActivities => [
    {
      'title': 'Factura #000124 aprobada',
      'subtitle': 'Cliente: Tienda Central',
      'time': 'Hace 5 min',
      'icon': Icons.receipt_long,
      'color': Colors.green,
    },
    {
      'title': 'Reposición inventario',
      'subtitle': 'Se agregaron 50 und de arroz',
      'time': 'Hace 20 min',
      'icon': Icons.inventory,
      'color': Colors.blueAccent,
    },
    {
      'title': 'Venta punto físico',
      'subtitle': 'Ticket promedio \$54.000',
      'time': 'Hace 1 h',
      'icon': Icons.store,
      'color': Colors.orange,
    },
  ];

  List<Map<String, dynamic>> get _topProducts => [
    {'name': 'Arroz premium 500g', 'sold': '74 und', 'trend': '+6%'},
    {'name': 'Café molido 250g', 'sold': '68 und', 'trend': '+18%'},
    {'name': 'Aceite vegetal 1L', 'sold': '51 und', 'trend': '-4%'},
  ];

  Widget _buildSummaryGrid(BoxConstraints constraints) {
    final isWide = constraints.maxWidth > 600;
    final itemWidth = isWide
        ? constraints.maxWidth / 2 - 12
        : constraints.maxWidth;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _mainStats
          .map(
            (stat) => SizedBox(
              width: itemWidth,
              child: SummaryCard(
                label: stat['title'],
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
      appBar: const CustomAppBar(
        title: 'Panel de control',
        trailing: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.notifications, color: AppTheme.primary),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(
            title: 'Hola, Ana 👋',
            subtitle: 'Este es el estado de tu negocio hoy',
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return _buildSummaryGrid(constraints);
            },
          ),
          const SizedBox(height: 12),
          const SectionHeader(
            title: 'Acciones rápidas',
            subtitle: 'Todo lo crítico en un solo toque',
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ElevatedButton.icon(
                onPressed: () => context.go('/ventas'),
                icon: const Icon(Icons.point_of_sale),
                label: const Text('Nueva venta'),
              ),
              ElevatedButton.icon(
                onPressed: () => context.go('/inventario'),
                icon: const Icon(Icons.inventory_outlined),
                label: const Text('Ajustar stock'),
              ),
              ElevatedButton.icon(
                onPressed: () => context.go('/facturacion'),
                icon: const Icon(Icons.receipt),
                label: const Text('Emitir factura'),
              ),
            ],
          ),
          const SizedBox(height: 18),
          SectionHeader(
            title: 'Actividades recientes',
            subtitle: 'Últimas novedades operativas',
            actionText: 'Ver todo',
            onAction: () {},
          ),
          ..._recentActivities.map(
            (activity) => Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: (activity['color'] as Color).withValues(
                    alpha: 0.12,
                  ),
                  child: Icon(activity['icon'], color: activity['color']),
                ),
                title: Text(activity['title']),
                subtitle: Text('${activity['subtitle']} • ${activity['time']}'),
                trailing: IconButton(
                  icon: const Icon(Icons.open_in_new),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          const SectionHeader(
            title: 'Rendimiento por categoría',
            subtitle: 'Productos más vendidos del día',
          ),
          Card(
            child: Column(
              children: _topProducts
                  .map(
                    (product) => ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        child: const Icon(
                          Icons.local_offer,
                          color: AppTheme.primary,
                        ),
                      ),
                      title: Text(product['name']),
                      subtitle: Text('Ventas: ${product['sold']}'),
                      trailing: Text(
                        product['trend'],
                        style: TextStyle(
                          color: product['trend'].toString().contains('-')
                              ? Colors.redAccent
                              : Colors.green,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 0),
    );
  }
}
