import 'model_utils.dart';

class Pago {
  final int? id;
  final bool propina;
  final String? medioDePago;
  final double? dineroRecibido;

  const Pago({
    this.id,
    this.propina = false,
    this.medioDePago,
    this.dineroRecibido,
  });

  Pago copyWith({
    int? id,
    bool? propina,
    String? medioDePago,
    double? dineroRecibido,
  }) {
    return Pago(
      id: id ?? this.id,
      propina: propina ?? this.propina,
      medioDePago: medioDePago ?? this.medioDePago,
      dineroRecibido: dineroRecibido ?? this.dineroRecibido,
    );
  }

  factory Pago.fromJson(Map<String, dynamic> json) {
    return Pago(
      id: parseInt(json['id']),
      propina: json['propina'] as bool? ?? false,
      medioDePago: json['medio_de_pago'] as String?,
      dineroRecibido: parseDouble(json['dinero_recibido']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propina': propina,
      'medio_de_pago': medioDePago,
      'dinero_recibido': dineroRecibido,
    };
  }
}
