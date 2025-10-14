import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../themes/app_theme.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNav({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/inventario');
        break;
      case 2:
        context.go('/ventas');
        break;
      case 3:
        context.go('/facturacion');
        break;
      case 4:
        context.go('/contabilidad');
        break;
      case 5:
        context.go('/clientes');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (i) => _onTap(context, i),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppTheme.primary,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Inicio'),
        BottomNavigationBarItem(
          icon: Icon(Icons.inventory_2),
          label: 'Inventario',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Ventas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long),
          label: 'Facturación',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: 'Contabilidad',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_alt),
          label: 'Clientes',
        ),
      ],
    );
  }
}
