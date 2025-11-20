import '../models/venta.dart';
import 'api_client.dart';

class VentaService {
  VentaService({ApiClient? client}) : _apiClient = client ?? apiClient;

  final ApiClient _apiClient;
  static const _basePath = '/ventas';

  Future<List<Venta>> fetchAll() async {
    final data = await _apiClient.get('$_basePath/');
    return (data as List<dynamic>)
        .map((item) => Venta.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Venta> fetchById(int id) async {
    final data = await _apiClient.get('$_basePath/$id');
    return Venta.fromJson(data as Map<String, dynamic>);
  }

  Future<Venta> create(Venta venta) async {
    final payload = venta.toJson(
      includeApertura: false,
      includeCliente: false,
      includePago: false,
      includeDetalles: true,
    )..remove('id');
    final data = await _apiClient.post('$_basePath/', body: payload);
    return Venta.fromJson(data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _apiClient.delete('$_basePath/$id');
  }
}
