import 'model_utils.dart';
import 'usuario.dart';

class AperturaCaja {
  final int? id;
  final DateTime? fecha;
  final double? efectivoInicial;
  final double? monedasIniciales;
  final String? observaciones;
  final int? estado;
  final int? usuarioId;
  final Usuario? usuario;

  const AperturaCaja({
    this.id,
    this.fecha,
    this.efectivoInicial,
    this.monedasIniciales,
    this.observaciones,
    this.estado,
    this.usuarioId,
    this.usuario,
  });

  AperturaCaja copyWith({
    int? id,
    DateTime? fecha,
    double? efectivoInicial,
    double? monedasIniciales,
    String? observaciones,
    int? estado,
    int? usuarioId,
    Usuario? usuario,
  }) {
    return AperturaCaja(
      id: id ?? this.id,
      fecha: fecha ?? this.fecha,
      efectivoInicial: efectivoInicial ?? this.efectivoInicial,
      monedasIniciales: monedasIniciales ?? this.monedasIniciales,
      observaciones: observaciones ?? this.observaciones,
      estado: estado ?? this.estado,
      usuarioId: usuarioId ?? this.usuarioId,
      usuario: usuario ?? this.usuario,
    );
  }

  factory AperturaCaja.fromJson(Map<String, dynamic> json) {
    return AperturaCaja(
      id: parseInt(json['id']),
      fecha: parseDate(json['fecha']),
      efectivoInicial: parseDouble(json['efectivo_inicial']),
      monedasIniciales: parseDouble(json['monedas_iniciales']),
      observaciones: json['observaciones'] as String?,
      estado: parseInt(json['estado']),
      usuarioId: parseInt(json['usuario_id']),
      usuario: json['usuario'] != null
          ? Usuario.fromJson(json['usuario'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson({bool includeUsuario = true}) {
    return {
      'id': id,
      'fecha': dateToJson(fecha),
      'efectivo_inicial': efectivoInicial,
      'monedas_iniciales': monedasIniciales,
      'observaciones': observaciones,
      'estado': estado,
      'usuario_id': usuarioId ?? usuario?.id,
      if (includeUsuario && usuario != null) 'usuario': usuario!.toJson(),
    };
  }
}
