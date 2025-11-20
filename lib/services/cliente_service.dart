import '../models/clientes.dart';
import 'api_client.dart';

class ClienteService {
  ClienteService({ApiClient? client}) : _apiClient = client ?? apiClient;

  final ApiClient _apiClient;
  static const _basePath = '/clientes';

  Future<List<Cliente>> fetchAll() async {
    final data = await _apiClient.get('$_basePath/');
    return (data as List<dynamic>)
        .map((item) => Cliente.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Cliente> fetchById(int id) async {
    final data = await _apiClient.get('$_basePath/$id');
    return Cliente.fromJson(data as Map<String, dynamic>);
  }

  Future<Cliente> create(Cliente cliente) async {
    final payload = cliente.toJson()..remove('id');
    final data = await _apiClient.post('$_basePath/', body: payload);
    return Cliente.fromJson(data as Map<String, dynamic>);
  }

  Future<Cliente> update(int id, Cliente cliente) async {
    final payload = cliente.toJson()..remove('id');
    final data = await _apiClient.put('$_basePath/$id', body: payload);
    return Cliente.fromJson(data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _apiClient.delete('$_basePath/$id');
  }
}
