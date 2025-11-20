import 'package:flutter/material.dart';

import '../themes/app_theme.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/section_header.dart';
import '../widgets/status_pill.dart';
import '../widgets/summary_card.dart';

class FacturacionView extends StatefulWidget {
  const FacturacionView({super.key});

  @override
  State<FacturacionView> createState() => _FacturacionViewState();
}

class _FacturacionViewState extends State<FacturacionView> {
  final statuses = ['Todas', 'Aprobada', 'Pendiente', 'Rechazada'];
  int selectedStatus = 0;

  final invoices = [
    {
      'id': '000124',
      'client': 'Tienda Central',
      'date': '02/05/2025',
      'total': 120000,
      'status': 'Aprobada',
    },
    {
      'id': '000123',
      'client': 'Restaurante Marea',
      'date': '01/05/2025',
      'total': 98000,
      'status': 'Pendiente',
    },
    {
      'id': '000122',
      'client': 'Mercado San Luis',
      'date': '28/04/2025',
      'total': 210000,
      'status': 'Rechazada',
    },
    {
      'id': '000121',
      'client': 'Comidas Rápidas Ya',
      'date': '26/04/2025',
      'total': 87000,
      'status': 'Aprobada',
    },
  ];

  List<Map<String, dynamic>> get _billingStats => [
    {
      'label': 'Emitidas mes',
      'value': '48',
      'helper': '+6 vs abril',
      'icon': Icons.receipt_long,
      'color': AppTheme.primary,
    },
    {
      'label': 'Pendiente de cobro',
      'value': '\$ 540.000',
      'helper': '9 facturas',
      'icon': Icons.payments_outlined,
      'color': Colors.orange,
    },
    {
      'label': 'Promedio pago',
      'value': '12 días',
      'helper': 'Objetivo: 10 días',
      'icon': Icons.timer,
      'color': Colors.blueAccent,
    },
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'Aprobada':
        return Colors.green;
      case 'Pendiente':
        return Colors.orange;
      case 'Rechazada':
        return Colors.redAccent;
      default:
        return AppTheme.muted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Facturación',
        trailing: IconButton(
          icon: const Icon(Icons.download),
          onPressed: () {},
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Generar factura'),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 700;
              final width = isWide
                  ? constraints.maxWidth / 2 - 8
                  : constraints.maxWidth;
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _billingStats
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
          const SizedBox(height: 10),
          const SectionHeader(
            title: 'Facturas emitidas',
            subtitle: 'Filtra por estado o fecha',
          ),
          Wrap(
            spacing: 6,
            children: List.generate(
              statuses.length,
              (index) => ChoiceChip(
                label: Text(statuses[index]),
                selected: selectedStatus == index,
                onSelected: (_) => setState(() => selectedStatus = index),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Rango de fechas'),
              subtitle: const Text('01/04/2025 - 02/05/2025'),
              trailing: IconButton(
                icon: const Icon(Icons.edit_calendar),
                onPressed: () {},
              ),
            ),
          ),
          const SizedBox(height: 8),
          ...invoices
              .where(
                (invoice) =>
                    selectedStatus == 0 ||
                    invoice['status'] == statuses[selectedStatus],
              )
              .map(
                (invoice) => Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _statusColor(
                        invoice['status'] as String,
                      ).withValues(alpha: 0.15),
                      child: const Icon(Icons.receipt_long),
                    ),
                    title: Text('Factura #${invoice['id']}'),
                    subtitle: Text('${invoice['client']} • ${invoice['date']}'),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\$${invoice['total']}',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6),
                        StatusPill(
                          label: invoice['status'] as String,
                          color: _statusColor(invoice['status'] as String),
                          icon: Icons.circle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          const SizedBox(height: 24),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 3),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.picture_as_pdf),
        label: const Text('Exportar PDF'),
      ),
    );
  }
}
