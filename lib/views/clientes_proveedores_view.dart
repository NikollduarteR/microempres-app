import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_bottom_nav.dart';

class ClientesProveedoresView extends StatelessWidget {
  const ClientesProveedoresView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Clientes y Proveedores'),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, i) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('C${i + 1}')),
              title: Text('Cliente ${i + 1}'),
              subtitle: const Text('Tel: 300 123 4567'),
              trailing: ElevatedButton(
                onPressed: () {},
                child: const Text('Ver'),
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemCount: 8,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.person_add),
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 5),
    );
  }
}
