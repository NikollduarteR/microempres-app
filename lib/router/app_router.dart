import 'package:go_router/go_router.dart';

import '../views/dashboard_view.dart';
import '../views/inventario_view.dart';
import '../views/ventas_view.dart';
import '../views/facturacion_view.dart';
import '../views/contabilidad_view.dart';
import '../views/clientes_proveedores_view.dart';
import '../views/login_view.dart';

/// Configuración de rutas con GoRouter
final GoRouter appRouter = GoRouter(
  initialLocation: '/login', // Vista inicial
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/',
      name: 'dashboard',
      builder: (context, state) => const DashboardView(),
    ),
    GoRoute(
      path: '/inventario',
      name: 'inventario',
      builder: (context, state) => const InventarioView(),
    ),
    GoRoute(
      path: '/ventas',
      name: 'ventas',
      builder: (context, state) => const VentasView(),
    ),
    GoRoute(
      path: '/facturacion',
      name: 'facturacion',
      builder: (context, state) => const FacturacionView(),
    ),
    GoRoute(
      path: '/contabilidad',
      name: 'contabilidad',
      builder: (context, state) => const ContabilidadView(),
    ),
    GoRoute(
      path: '/clientes',
      name: 'clientes',
      builder: (context, state) => const ClientesProveedoresView(),
    ),
  ],
);
