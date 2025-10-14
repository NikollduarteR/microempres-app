import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_bottom_nav.dart';

class FacturacionView extends StatelessWidget {
  const FacturacionView({super.key});

  Widget invoiceTile(String id, String date, String total, String status) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: const Icon(Icons.receipt_long)),
        title: Text('Factura #$id'),
        subtitle: Text('$date • Estado: $status'),
        trailing: Text(
          total,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Facturación'),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Generar factura'),
          ),
          const SizedBox(height: 12),
          invoiceTile('000123', '02/05/2025', '\$120.000', 'Aprobada'),
          invoiceTile('000122', '28/04/2025', '\$75.000', 'Pendiente'),
          invoiceTile('000121', '20/04/2025', '\$210.000', 'Rechazada'),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 3),
    );
  }
}
