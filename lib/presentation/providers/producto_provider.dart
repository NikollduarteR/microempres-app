import '../../core/errors/failure.dart';
import '../../core/utils/result.dart';
import '../../data/repositories/producto_repository.dart';
import '../../models/productos.dart';

import 'base_provider.dart';

class ProductoProvider extends BaseProvider {
  ProductoProvider({required ProductoRepository repository})
      : _repository = repository;

  final ProductoRepository _repository;

  List<Producto> _productos = <Producto>[];
  Producto? _selected;

  List<Producto> get productos => _productos;
  Producto? get selected => _selected;

  Future<void> loadProductos({String? query}) async {
    setLoading();
    final Result<List<Producto>> result =
        await _repository.getProductos(query: query);
    if (result.isSuccess && result.data != null) {
      _productos = result.data!;
      setSuccess();
    } else {
      setError(
        result.failure ??
            const UnknownFailure('Error desconocido al cargar productos'),
      );
    }
  }

  Future<void> selectProducto(int id) async {
    setLoading();
    final Result<Producto> result = await _repository.getProducto(id);
    if (result.isSuccess && result.data != null) {
      _selected = result.data;
      setSuccess();
    } else {
      setError(
        result.failure ??
            const UnknownFailure('Error desconocido al cargar el producto'),
      );
    }
  }

  Future<bool> crearProducto(Producto producto) async {
    setLoading();
    final Result<Producto> result =
        await _repository.createProducto(producto);
    if (result.isSuccess && result.data != null) {
      _productos = List<Producto>.from(_productos)..add(result.data!);
      setSuccess();
      return true;
    }
    setError(
      result.failure ??
          const UnknownFailure('Error desconocido al crear el producto'),
    );
    return false;
  }

  Future<bool> actualizarProducto(Producto producto) async {
    setLoading();
    final Result<Producto> result =
        await _repository.updateProducto(producto);
    if (result.isSuccess && result.data != null) {
      final updated = result.data!;
      _productos = _productos
          .map((p) => p.id == updated.id ? updated : p)
          .toList(growable: false);
      _selected = updated;
      setSuccess();
      return true;
    }
    setError(
      result.failure ??
          const UnknownFailure('Error desconocido al actualizar el producto'),
    );
    return false;
  }

  Future<bool> eliminarProducto(int id) async {
    setLoading();
    final Result<void> result = await _repository.deleteProducto(id);
    if (result.isSuccess) {
      _productos = _productos
          .where((p) => p.id != id)
          .toList(growable: false);
      if (_selected?.id == id) {
        _selected = null;
      }
      setSuccess();
      return true;
    }
    setError(
      result.failure ??
          const UnknownFailure('Error desconocido al eliminar el producto'),
    );
    return false;
  }

  void clearSelection() {
    _selected = null;
    notifyListeners();
  }
}
