import 'model_utils.dart';

class Usuario {
  final int? id;
  final String nombre;
  final String correo;
  final String? username;
  final String? password;
  final String? fechaNacimiento;
  final DateTime? fechaModificacion;
  final DateTime? fechaCreacion;
  final String? telefono1;
  final String? telefono2;
  final String? rol;
  final bool estado;
  final String? cedula;

  const Usuario({
    this.id,
    required this.nombre,
    required this.correo,
    this.username,
    this.password,
    this.fechaNacimiento,
    this.fechaModificacion,
    this.fechaCreacion,
    this.telefono1,
    this.telefono2,
    this.rol,
    this.estado = true,
    this.cedula,
  });

  Usuario copyWith({
    int? id,
    String? nombre,
    String? correo,
    String? username,
    String? password,
    String? fechaNacimiento,
    DateTime? fechaModificacion,
    DateTime? fechaCreacion,
    String? telefono1,
    String? telefono2,
    String? rol,
    bool? estado,
    String? cedula,
  }) {
    return Usuario(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      correo: correo ?? this.correo,
      username: username ?? this.username,
      password: password ?? this.password,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      fechaModificacion: fechaModificacion ?? this.fechaModificacion,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      telefono1: telefono1 ?? this.telefono1,
      telefono2: telefono2 ?? this.telefono2,
      rol: rol ?? this.rol,
      estado: estado ?? this.estado,
      cedula: cedula ?? this.cedula,
    );
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: parseInt(json['id']),
      nombre: (json['nombre'] ?? '') as String,
      correo: (json['correo'] ?? '') as String,
      username: json['username'] as String?,
      password: json['password'] as String?,
      fechaNacimiento: json['fecha_nacimiento'] as String?,
      fechaModificacion: parseDate(json['fecha_modificacion']),
      fechaCreacion: parseDate(json['fecha_creacion']),
      telefono1: json['telefono_1'] as String?,
      telefono2: json['telefono_2'] as String?,
      rol: json['rol'] as String?,
      estado: json['estado'] as bool? ?? true,
      cedula: json['cedula'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'correo': correo,
      'username': username,
      'password': password,
      'fecha_nacimiento': fechaNacimiento,
      'fecha_modificacion': dateToJson(fechaModificacion),
      'fecha_creacion': dateToJson(fechaCreacion),
      'telefono_1': telefono1,
      'telefono_2': telefono2,
      'rol': rol,
      'estado': estado,
      'cedula': cedula,
    };
  }
}
