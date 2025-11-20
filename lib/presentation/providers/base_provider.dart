import 'package:flutter/foundation.dart';

import '../../core/errors/failure.dart';

enum ViewState { idle, loading, success, error }

class BaseProvider extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  Failure? _failure;

  ViewState get state => _state;
  bool get isLoading => _state == ViewState.loading;
  bool get hasError => _state == ViewState.error;
  Failure? get failure => _failure;
  String? get errorMessage => _failure?.message;

  void setIdle() {
    _state = ViewState.idle;
    _failure = null;
    notifyListeners();
  }

  void setLoading() {
    _state = ViewState.loading;
    _failure = null;
    notifyListeners();
  }

  void setSuccess() {
    _state = ViewState.success;
    notifyListeners();
  }

  void setError(Failure failure) {
    _state = ViewState.error;
    _failure = failure;
    notifyListeners();
  }
}
