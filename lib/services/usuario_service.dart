import '../models/usuario.dart';
import 'api_client.dart';

class UsuarioService {
  UsuarioService({ApiClient? client}) : _apiClient = client ?? apiClient;

  final ApiClient _apiClient;
  static const _basePath = '/usuarios';

  Future<List<Usuario>> fetchAll() async {
    final data = await _apiClient.get('$_basePath/');
    return (data as List<dynamic>)
        .map((item) => Usuario.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Usuario> fetchById(int id) async {
    final data = await _apiClient.get('$_basePath/$id');
    return Usuario.fromJson(data as Map<String, dynamic>);
  }

  Future<Usuario> create(Usuario usuario) async {
    final payload = usuario.toJson()..remove('id');
    final data = await _apiClient.post('$_basePath/', body: payload);
    return Usuario.fromJson(data as Map<String, dynamic>);
  }

  Future<Usuario> update(int id, Usuario usuario) async {
    final payload = usuario.toJson()..remove('id');
    final data = await _apiClient.put('$_basePath/$id', body: payload);
    return Usuario.fromJson(data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _apiClient.delete('$_basePath/$id');
  }
}
