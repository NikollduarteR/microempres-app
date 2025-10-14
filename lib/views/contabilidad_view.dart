import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_bottom_nav.dart';

class ContabilidadView extends StatelessWidget {
  const ContabilidadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Contabilidad'),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Resumen mensual',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 8),
                  Text('Ingresos: \$3.400.000'),
                  Text('Egresos: \$1.200.000'),
                  SizedBox(height: 8),
                  Text(
                    'Balance: \$2.200.000',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.receipt),
              title: const Text('Crear asiento contable'),
              trailing: ElevatedButton(
                onPressed: () {},
                child: const Text('Nuevo'),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Reportes', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              title: const Text('Reporte IVA mensual'),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.download),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Balance general'),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.download),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 4),
    );
  }
}
