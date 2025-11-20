import 'model_utils.dart';

class Categoria {
  final int? id;
  final String nombre;
  final String? descripcion;

  const Categoria({this.id, required this.nombre, this.descripcion});

  Categoria copyWith({int? id, String? nombre, String? descripcion}) {
    return Categoria(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
    );
  }

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: parseInt(json['id']),
      nombre: (json['nombre'] ?? '') as String,
      descripcion: json['descripcion'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nombre': nombre, 'descripcion': descripcion};
  }
}
