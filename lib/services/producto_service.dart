import '../models/productos.dart';
import 'api_client.dart';

class ProductoService {
  ProductoService({ApiClient? client}) : _apiClient = client ?? apiClient;

  final ApiClient _apiClient;
  static const _basePath = '/productos';

  Future<List<Producto>> fetchAll({String? query}) async {
    final data = await _apiClient.get(
      '$_basePath/',
      queryParameters: {'q': query},
    );
    return (data as List<dynamic>)
        .map((item) => Producto.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Producto> fetchById(int id) async {
    final data = await _apiClient.get('$_basePath/$id');
    return Producto.fromJson(data as Map<String, dynamic>);
  }

  Future<Producto> create(Producto producto) async {
    final payload = producto.toJson(includeCategoria: false)..remove('id');
    final data = await _apiClient.post('$_basePath/', body: payload);
    return Producto.fromJson(data as Map<String, dynamic>);
  }

  Future<Producto> update(int id, Producto producto) async {
    final payload = producto.toJson(includeCategoria: false)..remove('id');
    final data = await _apiClient.put('$_basePath/$id', body: payload);
    return Producto.fromJson(data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _apiClient.delete('$_basePath/$id');
  }
}
