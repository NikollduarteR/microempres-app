import 'categoria.dart';
import 'model_utils.dart';

class Producto {
  final int? id;
  final String nombre;
  final double? precioDeVenta;
  final int? stock;
  final DateTime? fechaCreacion;
  final DateTime? modificacion;
  final String? codigoBarras;
  final int? categoriaId;
  final Categoria? categoria;

  const Producto({
    this.id,
    required this.nombre,
    this.precioDeVenta,
    this.stock,
    this.fechaCreacion,
    this.modificacion,
    this.codigoBarras,
    this.categoriaId,
    this.categoria,
  });

  Producto copyWith({
    int? id,
    String? nombre,
    double? precioDeVenta,
    int? stock,
    DateTime? fechaCreacion,
    DateTime? modificacion,
    String? codigoBarras,
    int? categoriaId,
    Categoria? categoria,
  }) {
    return Producto(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      precioDeVenta: precioDeVenta ?? this.precioDeVenta,
      stock: stock ?? this.stock,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      modificacion: modificacion ?? this.modificacion,
      codigoBarras: codigoBarras ?? this.codigoBarras,
      categoriaId: categoriaId ?? this.categoriaId,
      categoria: categoria ?? this.categoria,
    );
  }

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: parseInt(json['id']),
      nombre: (json['nombre'] ?? '') as String,
      precioDeVenta: parseDouble(json['precio_de_venta']),
      stock: parseInt(json['stock']),
      fechaCreacion: parseDate(json['fecha_creacion']),
      modificacion: parseDate(json['modificacion']),
      codigoBarras: json['codigo_barras'] as String?,
      categoriaId: parseInt(json['categoria_id']),
      categoria: json['categoria'] != null
          ? Categoria.fromJson(json['categoria'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson({bool includeCategoria = true}) {
    return {
      'id': id,
      'nombre': nombre,
      'precio_de_venta': precioDeVenta,
      'stock': stock,
      'fecha_creacion': dateToJson(fechaCreacion),
      'modificacion': dateToJson(modificacion),
      'codigo_barras': codigoBarras,
      'categoria_id': categoriaId ?? categoria?.id,
      if (includeCategoria && categoria != null)
        'categoria': categoria!.toJson(),
    };
  }
}
