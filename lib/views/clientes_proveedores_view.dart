import 'package:flutter/material.dart';

import '../themes/app_theme.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/section_header.dart';
import '../widgets/summary_card.dart';

class ClientesProveedoresView extends StatelessWidget {
  const ClientesProveedoresView({super.key});

  List<Map<String, dynamic>> get _peopleStats => [
    {
      'label': 'Clientes activos',
      'value': '234',
      'helper': '+12 esta semana',
      'icon': Icons.people_alt,
      'color': AppTheme.primary,
    },
    {
      'label': 'Proveedores',
      'value': '34',
      'helper': '5 estratégicos',
      'icon': Icons.store_mall_directory,
      'color': Colors.orange,
    },
  ];

  static final clients = List.generate(
    6,
    (index) => {
      'name': 'Cliente ${index + 1}',
      'segment': index.isEven ? 'Mayorista' : 'Retail',
      'phone': '300 123 45${index}7',
      'balance': index.isEven ? '\$ -120.000' : '\$ 0',
    },
  );

  static final suppliers = List.generate(
    5,
    (index) => {
      'name': 'Proveedor ${index + 1}',
      'category': index.isOdd ? 'Frescos' : 'Abarrotes',
      'phone': '310 555 12${index}0',
      'status': index.isOdd ? 'Entrega semanal' : 'Entrega diaria',
    },
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Relaciones comerciales',
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Clientes'),
              Tab(text: 'Proveedores'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _ContactsTab(
              title: 'Clientes',
              stats: _peopleStats.sublist(0, 1),
              contacts: clients,
              trailingBuilder: (item) => Text(
                item['balance'] as String,
                style: TextStyle(
                  color: (item['balance'] as String).startsWith('-')
                      ? Colors.redAccent
                      : Colors.green,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitleBuilder: (item) =>
                  '${item['segment']} • Tel: ${item['phone']}',
              actionLabel: 'Detalle',
            ),
            _ContactsTab(
              title: 'Proveedores',
              stats: _peopleStats.sublist(1),
              contacts: suppliers,
              trailingBuilder: (item) => const Icon(Icons.chevron_right),
              subtitleBuilder: (item) =>
                  '${item['category']} • ${item['status']}',
              actionLabel: 'Ver',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          icon: const Icon(Icons.person_add_alt_1),
          label: const Text('Nuevo contacto'),
        ),
        bottomNavigationBar: const CustomBottomNav(currentIndex: 5),
      ),
    );
  }
}

class _ContactsTab extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> stats;
  final List<Map<String, dynamic>> contacts;
  final String actionLabel;
  final Widget Function(Map<String, dynamic> item) trailingBuilder;
  final String Function(Map<String, dynamic> item) subtitleBuilder;

  const _ContactsTab({
    required this.title,
    required this.stats,
    required this.contacts,
    required this.actionLabel,
    required this.trailingBuilder,
    required this.subtitleBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        const SizedBox(height: 4),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth > 600
                ? constraints.maxWidth / 2 - 8
                : constraints.maxWidth;
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: stats
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
        SectionHeader(
          title: title,
          subtitle: 'Segmenta y gestiona tus contactos',
          icon: Icons.people_alt_outlined,
          actionText: 'Ver historial',
          onAction: () {},
        ),
        ...contacts.map(
          (item) => Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppTheme.primary.withValues(alpha: 0.15),
                child: Text(item['name'].toString()[0]),
              ),
              title: Text(item['name'] as String),
              subtitle: Text(subtitleBuilder(item)),
              trailing: trailingBuilder(item),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
