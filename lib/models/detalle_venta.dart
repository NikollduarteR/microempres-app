import 'model_utils.dart';
import 'productos.dart';

class DetalleVenta {
  final int? id;
  final double? valorUnitario;
  final int? cantidad;
  final double? montoTotal;
  final int? ventaId;
  final int? productoId;
  final Producto? producto;

  const DetalleVenta({
    this.id,
    this.valorUnitario,
    this.cantidad,
    this.montoTotal,
    this.ventaId,
    this.productoId,
    this.producto,
  });

  DetalleVenta copyWith({
    int? id,
    double? valorUnitario,
    int? cantidad,
    double? montoTotal,
    int? ventaId,
    int? productoId,
    Producto? producto,
  }) {
    return DetalleVenta(
      id: id ?? this.id,
      valorUnitario: valorUnitario ?? this.valorUnitario,
      cantidad: cantidad ?? this.cantidad,
      montoTotal: montoTotal ?? this.montoTotal,
      ventaId: ventaId ?? this.ventaId,
      productoId: productoId ?? this.productoId,
      producto: producto ?? this.producto,
    );
  }

  factory DetalleVenta.fromJson(Map<String, dynamic> json) {
    return DetalleVenta(
      id: parseInt(json['id']),
      valorUnitario: parseDouble(json['valor_unitario']),
      cantidad: parseInt(json['cantidad']),
      montoTotal: parseDouble(json['monto_total']),
      ventaId: parseInt(json['venta_id']),
      productoId: parseInt(json['productos_id']),
      producto: json['producto'] != null
          ? Producto.fromJson(json['producto'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson({bool includeProducto = true}) {
    return {
      'id': id,
      'valor_unitario': valorUnitario,
      'cantidad': cantidad,
      'monto_total': montoTotal,
      'venta_id': ventaId,
      'productos_id': productoId ?? producto?.id,
      if (includeProducto && producto != null) 'producto': producto!.toJson(),
    };
  }
}
