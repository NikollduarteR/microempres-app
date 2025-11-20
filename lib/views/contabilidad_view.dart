import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/section_header.dart';
import '../widgets/status_pill.dart';
import '../widgets/summary_card.dart';

class ContabilidadView extends StatelessWidget {
  const ContabilidadView({super.key});

  List<Map<String, dynamic>> get _accountingStats => [
    {
      'label': 'Ingresos mes',
      'value': '\$ 3.400.000',
      'helper': '+9% vs mayo',
      'icon': Icons.trending_up,
      'color': Colors.green,
    },
    {
      'label': 'Egresos mes',
      'value': '\$ 1.200.000',
      'helper': '-4% vs mayo',
      'icon': Icons.trending_down,
      'color': Colors.redAccent,
    },
    {
      'label': 'Balance acumulado',
      'value': '\$ 2.200.000',
      'helper': 'Objetivo: \$ 2.5M',
      'icon': Icons.balance,
      'color': AppTheme.primary,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Contabilidad'),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 650;
              final width = isWide
                  ? constraints.maxWidth / 2 - 10
                  : constraints.maxWidth;
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _accountingStats
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
            title: 'Flujo de caja',
            subtitle: 'Estado de ingresos vs egresos',
            icon: Icons.account_balance_wallet,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Cashflow semanal'),
                  const SizedBox(height: 12),
                  _progressRow('Semana 1', 0.75),
                  _progressRow('Semana 2', 0.62),
                  _progressRow('Semana 3', 0.82),
                  _progressRow('Semana 4', 0.58),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(
            title: 'Cuentas por cobrar / pagar',
            subtitle: 'Prioriza tus vencimientos',
            icon: Icons.receipt_long,
          ),
          Card(
            child: Column(
              children: const [
                ListTile(
                  leading: Icon(Icons.call_received, color: Colors.green),
                  title: Text('Por cobrar • \$540.000'),
                  subtitle: Text('9 facturas, vencen en 12 días'),
                  trailing: StatusPill(
                    label: 'Prioridad media',
                    color: Colors.orange,
                  ),
                ),
                Divider(height: 0),
                ListTile(
                  leading: Icon(Icons.call_made, color: Colors.redAccent),
                  title: Text('Por pagar • \$310.000'),
                  subtitle: Text('5 facturas, próxima fecha 05/05'),
                  trailing: StatusPill(
                    label: 'Revisar hoy',
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.receipt),
              title: const Text('Crear asiento contable'),
              subtitle: const Text('Último registro hace 2 horas'),
              trailing: ElevatedButton(
                onPressed: () {},
                child: const Text('Nuevo'),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(
            title: 'Reportes',
            subtitle: 'Exporta tus estados financieros',
            icon: Icons.insert_chart,
          ),
          Card(
            child: ListTile(
              title: const Text('Reporte IVA mensual'),
              subtitle: const Text('Formato DIAN'),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.download),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Balance general'),
              subtitle: const Text('Actualizado al día de hoy'),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.download),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 4),
    );
  }

  Widget _progressRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text('${(value * 100).toStringAsFixed(0)}%'),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: value,
            minHeight: 6,
            borderRadius: BorderRadius.circular(4),
            backgroundColor: AppTheme.muted.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
          ),
        ],
      ),
    );
  }
}
