import 'model_utils.dart';

class Cliente {
  final int? id;
  final String nombre;
  final String? direccion;
  final String? telefono;
  final DateTime? fechaCreacion;
  final String? email;
  final bool estado;
  final String? cedulaVendedor;
  final String? fechaNacimiento;
  final DateTime? fechaModificacion;
  final String? cedula;

  const Cliente({
    this.id,
    required this.nombre,
    this.direccion,
    this.telefono,
    this.fechaCreacion,
    this.email,
    this.estado = true,
    this.cedulaVendedor,
    this.fechaNacimiento,
    this.fechaModificacion,
    this.cedula,
  });

  Cliente copyWith({
    int? id,
    String? nombre,
    String? direccion,
    String? telefono,
    DateTime? fechaCreacion,
    String? email,
    bool? estado,
    String? cedulaVendedor,
    String? fechaNacimiento,
    DateTime? fechaModificacion,
    String? cedula,
  }) {
    return Cliente(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      direccion: direccion ?? this.direccion,
      telefono: telefono ?? this.telefono,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      email: email ?? this.email,
      estado: estado ?? this.estado,
      cedulaVendedor: cedulaVendedor ?? this.cedulaVendedor,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      fechaModificacion: fechaModificacion ?? this.fechaModificacion,
      cedula: cedula ?? this.cedula,
    );
  }

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: parseInt(json['id']),
      nombre: (json['nombre'] ?? '') as String,
      direccion: json['direccion'] as String?,
      telefono: json['telefono'] as String?,
      fechaCreacion: parseDate(json['fecha_creacion']),
      email: json['email'] as String?,
      estado: json['estado'] as bool? ?? true,
      cedulaVendedor: json['cedula_vendedor'] as String?,
      fechaNacimiento: json['fecha_nacimiento'] as String?,
      fechaModificacion: parseDate(json['fecha_modificacion']),
      cedula: json['cedula'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'direccion': direccion,
      'telefono': telefono,
      'fecha_creacion': dateToJson(fechaCreacion),
      'email': email,
      'estado': estado,
      'cedula_vendedor': cedulaVendedor,
      'fecha_nacimiento': fechaNacimiento,
      'fecha_modificacion': dateToJson(fechaModificacion),
      'cedula': cedula,
    };
  }
}
