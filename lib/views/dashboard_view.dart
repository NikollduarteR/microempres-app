import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_bottom_nav.dart';
import 'package:go_router/go_router.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  Widget _statCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.12),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: AppTheme.muted, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Panel de control'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 6),
          Row(
            children: const [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(14),
                    child: Text(
                      'Bienvenido, Usuario',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _statCard(
                'Ventas (mes)',
                '\$ 3.450.000',
                Icons.trending_up,
                Colors.green,
              ),
              _statCard(
                'Productos',
                '128',
                Icons.inventory_2,
                AppTheme.primary,
              ),
              _statCard('Clientes', '67', Icons.people_alt, Colors.orange),
              _statCard('Facturas', '24', Icons.receipt_long, Colors.blue),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Acciones rápidas',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ElevatedButton.icon(
                onPressed: () => context.go('/ventas'),
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Nueva venta'),
              ),
              ElevatedButton.icon(
                onPressed: () => context.go('/inventario'),
                icon: const Icon(Icons.add),
                label: const Text('Agregar producto'),
              ),
              ElevatedButton.icon(
                onPressed: () => context.go('/facturacion'),
                icon: const Icon(Icons.receipt),
                label: const Text('Facturar'),
              ),
            ],
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
