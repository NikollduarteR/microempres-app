import '../../core/errors/failure.dart';
import '../../core/utils/result.dart';
import '../../models/productos.dart';
import '../../services/api_client.dart';
import '../../services/producto_service.dart';

class ProductoRepository {
  ProductoRepository({ProductoService? service})
      : _service = service ?? ProductoService();

  final ProductoService _service;

  Future<Result<List<Producto>>> getProductos({String? query}) async {
    try {
      final items = await _service.fetchAll(query: query);
      return Result.success(items);
    } on ApiException catch (e) {
      return Result.error(
        ServerFailure(e.message, statusCode: e.statusCode),
      );
    } catch (e) {
      return Result.error(
        const UnknownFailure('Error desconocido al cargar productos'),
      );
    }
  }

  Future<Result<Producto>> getProducto(int id) async {
    try {
      final item = await _service.fetchById(id);
      return Result.success(item);
    } on ApiException catch (e) {
      return Result.error(
        ServerFailure(e.message, statusCode: e.statusCode),
      );
    } catch (e) {
      return Result.error(
        const UnknownFailure('Error desconocido al cargar el producto'),
      );
    }
  }

  Future<Result<Producto>> createProducto(Producto producto) async {
    try {
      final created = await _service.create(producto);
      return Result.success(created);
    } on ApiException catch (e) {
      return Result.error(
        ServerFailure(e.message, statusCode: e.statusCode),
      );
    } catch (e) {
      return Result.error(
        const UnknownFailure('Error desconocido al crear el producto'),
      );
    }
  }

  Future<Result<Producto>> updateProducto(Producto producto) async {
    if (producto.id == null) {
      return Result.error(
        const ValidationFailure('El id del producto es requerido para actualizar'),
      );
    }
    try {
      final updated = await _service.update(producto.id!, producto);
      return Result.success(updated);
    } on ApiException catch (e) {
      return Result.error(
        ServerFailure(e.message, statusCode: e.statusCode),
      );
    } catch (e) {
      return Result.error(
        const UnknownFailure('Error desconocido al actualizar el producto'),
      );
    }
  }

  Future<Result<void>> deleteProducto(int id) async {
    try {
      await _service.delete(id);
      return Result.success(null);
    } on ApiException catch (e) {
      return Result.error(
        ServerFailure(e.message, statusCode: e.statusCode),
      );
    } catch (e) {
      return Result.error(
        const UnknownFailure('Error desconocido al eliminar el producto'),
      );
    }
  }
}
