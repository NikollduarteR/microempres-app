import '../models/apertura_caja.dart';
import 'api_client.dart';

class AperturaCajaService {
  AperturaCajaService({ApiClient? client}) : _apiClient = client ?? apiClient;

  final ApiClient _apiClient;
  static const _basePath = '/aperturas';

  Future<List<AperturaCaja>> fetchAll() async {
    final data = await _apiClient.get('$_basePath/');
    return (data as List<dynamic>)
        .map((item) => AperturaCaja.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<AperturaCaja> fetchById(int id) async {
    final data = await _apiClient.get('$_basePath/$id');
    return AperturaCaja.fromJson(data as Map<String, dynamic>);
  }

  Future<AperturaCaja> create(AperturaCaja apertura) async {
    final payload = apertura.toJson(includeUsuario: false)..remove('id');
    final data = await _apiClient.post('$_basePath/', body: payload);
    return AperturaCaja.fromJson(data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _apiClient.delete('$_basePath/$id');
  }
}
