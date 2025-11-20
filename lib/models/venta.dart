import 'apertura_caja.dart';
import 'clientes.dart';
import 'detalle_venta.dart';
import 'model_utils.dart';
import 'pago.dart';

class Venta {
  final int? id;
  final DateTime? fecha;
  final String? descuento;
  final String? montoFinal;
  final String? numeroFactura;
  final int? clienteId;
  final int? aperturaCajaId;
  final int? pagoId;
  final Cliente? cliente;
  final AperturaCaja? apertura;
  final Pago? pago;
  final List<DetalleVenta> detalles;

  const Venta({
    this.id,
    this.fecha,
    this.descuento,
    this.montoFinal,
    this.numeroFactura,
    this.clienteId,
    this.aperturaCajaId,
    this.pagoId,
    this.cliente,
    this.apertura,
    this.pago,
    this.detalles = const [],
  });

  Venta copyWith({
    int? id,
    DateTime? fecha,
    String? descuento,
    String? montoFinal,
    String? numeroFactura,
    int? clienteId,
    int? aperturaCajaId,
    int? pagoId,
    Cliente? cliente,
    AperturaCaja? apertura,
    Pago? pago,
    List<DetalleVenta>? detalles,
  }) {
    return Venta(
      id: id ?? this.id,
      fecha: fecha ?? this.fecha,
      descuento: descuento ?? this.descuento,
      montoFinal: montoFinal ?? this.montoFinal,
      numeroFactura: numeroFactura ?? this.numeroFactura,
      clienteId: clienteId ?? this.clienteId,
      aperturaCajaId: aperturaCajaId ?? this.aperturaCajaId,
      pagoId: pagoId ?? this.pagoId,
      cliente: cliente ?? this.cliente,
      apertura: apertura ?? this.apertura,
      pago: pago ?? this.pago,
      detalles: detalles ?? this.detalles,
    );
  }

  factory Venta.fromJson(Map<String, dynamic> json) {
    return Venta(
      id: parseInt(json['id']),
      fecha: parseDate(json['fecha']),
      descuento: json['descuento'] as String?,
      montoFinal: json['monto_final'] as String?,
      numeroFactura: json['numero_factura'] as String?,
      clienteId: parseInt(json['clientes_id']),
      aperturaCajaId: parseInt(json['apertura_caja_id']),
      pagoId: parseInt(json['pago_id']),
      cliente: json['cliente'] != null
          ? Cliente.fromJson(json['cliente'] as Map<String, dynamic>)
          : null,
      apertura: json['apertura'] != null
          ? AperturaCaja.fromJson(json['apertura'] as Map<String, dynamic>)
          : null,
      pago: json['pago'] != null
          ? Pago.fromJson(json['pago'] as Map<String, dynamic>)
          : null,
      detalles:
          (json['detalles'] as List<dynamic>?)
              ?.map((e) => DetalleVenta.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson({
    bool includeCliente = true,
    bool includeApertura = true,
    bool includePago = true,
    bool includeDetalles = true,
  }) {
    return {
      'id': id,
      'fecha': dateToJson(fecha),
      'descuento': descuento,
      'monto_final': montoFinal,
      'numero_factura': numeroFactura,
      'clientes_id': clienteId ?? cliente?.id,
      'apertura_caja_id': aperturaCajaId ?? apertura?.id,
      'pago_id': pagoId ?? pago?.id,
      if (includeCliente && cliente != null) 'cliente': cliente!.toJson(),
      if (includeApertura && apertura != null) 'apertura': apertura!.toJson(),
      if (includePago && pago != null) 'pago': pago!.toJson(),
      if (includeDetalles) 'detalles': detalles.map((e) => e.toJson()).toList(),
    };
  }
}
