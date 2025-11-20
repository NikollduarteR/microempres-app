import 'api_client.dart';
import 'api_config.dart';

abstract class BaseService<T> {
  final String endpoint;
  final String baseUrl = apiBaseUrl;
  final ApiClient _apiClient = ApiClient();

  BaseService(this.endpoint);

  /// Converts a JSON map to a model instance
  T fromJson(Map<String, dynamic> json);

  /// Converts a model instance to a JSON map
  Map<String, dynamic> toJson(T item);

  /// Creates a new item
  Future<T> create(T item) async {
    try {
      final response = await _apiClient.post(
        '$endpoint/',
        body: toJson(item),
      );
      return fromJson(response);
    } catch (e) {
      throw Exception('Failed to create item: $e');
    }
  }

  /// Retrieves all items
  Future<List<T>> getAll() async {
    try {
      final response = await _apiClient.get('$endpoint/');
      return (response as List).map((item) => fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to load items: $e');
    }
  }

  /// Retrieves a single item by ID
  Future<T> getById(int id) async {
    try {
      final response = await _apiClient.get('$endpoint/$id/');
      return fromJson(response);
    } catch (e) {
      throw Exception('Failed to load item: $e');
    }
  }

  /// Updates an existing item
  Future<T> update(int id, T item) async {
    try {
      final response = await _apiClient.put(
        '$endpoint/$id/',
        body: toJson(item),
      );
      return fromJson(response);
    } catch (e) {
      throw Exception('Failed to update item: $e');
    }
  }

  /// Deletes an item by ID
  Future<void> delete(int id) async {
    try {
      await _apiClient.delete('$endpoint/$id/');
    } catch (e) {
      throw Exception('Failed to delete item: $e');
    }
  }
}
