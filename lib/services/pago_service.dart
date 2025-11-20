import '../models/pago.dart';
import 'api_client.dart';

class PagoService {
  PagoService({ApiClient? client}) : _apiClient = client ?? apiClient;

  final ApiClient _apiClient;
  static const _basePath = '/pagos';

  Future<List<Pago>> fetchAll() async {
    final data = await _apiClient.get('$_basePath/');
    return (data as List<dynamic>)
        .map((item) => Pago.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Pago> create(Pago pago) async {
    final payload = pago.toJson()..remove('id');
    final data = await _apiClient.post('$_basePath/', body: payload);
    return Pago.fromJson(data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _apiClient.delete('$_basePath/$id');
  }
}
