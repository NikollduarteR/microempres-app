import '../models/categoria.dart';
import 'api_client.dart';

class CategoriaService {
  CategoriaService({ApiClient? client}) : _apiClient = client ?? apiClient;

  final ApiClient _apiClient;
  static const _basePath = '/categorias';

  Future<List<Categoria>> fetchAll() async {
    final data = await _apiClient.get('$_basePath/');
    return (data as List<dynamic>)
        .map((item) => Categoria.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Categoria> fetchById(int id) async {
    final data = await _apiClient.get('$_basePath/$id');
    return Categoria.fromJson(data as Map<String, dynamic>);
  }

  Future<Categoria> create(Categoria categoria) async {
    final payload = categoria.toJson()..remove('id');
    final data = await _apiClient.post('$_basePath/', body: payload);
    return Categoria.fromJson(data as Map<String, dynamic>);
  }

  Future<Categoria> update(int id, Categoria categoria) async {
    final payload = categoria.toJson()..remove('id');
    final data = await _apiClient.put('$_basePath/$id', body: payload);
    return Categoria.fromJson(data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _apiClient.delete('$_basePath/$id');
  }
}
