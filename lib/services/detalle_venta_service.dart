import '../models/detalle_venta.dart';
import 'api_client.dart';

class DetalleVentaService {
  DetalleVentaService({ApiClient? client}) : _apiClient = client ?? apiClient;

  final ApiClient _apiClient;
  static const _basePath = '/detalles';

  Future<List<DetalleVenta>> fetchAll() async {
    final data = await _apiClient.get('$_basePath/');
    return (data as List<dynamic>)
        .map((item) => DetalleVenta.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<DetalleVenta> create(DetalleVenta detalle) async {
    final payload = detalle.toJson(includeProducto: false)..remove('id');
    final data = await _apiClient.post('$_basePath/', body: payload);
    return DetalleVenta.fromJson(data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _apiClient.delete('$_basePath/$id');
  }
}
