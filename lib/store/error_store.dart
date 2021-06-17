import 'package:mobx/mobx.dart';

part 'error_store.g.dart';

class ErrorStore extends _ErrorStore with _$ErrorStore {
  factory ErrorStore() => _instance;
  ErrorStore._();
  static final ErrorStore _instance = ErrorStore._();
}

abstract class _ErrorStore with Store {
  // disposers
  late List<ReactionDisposer> _disposers;

  // constructor:---------------------------------------------------------------
  _ErrorStore() {
    _disposers = [
      reaction((_) => errorMessage, reset, delay: 200),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String errorMessage = '';

  // actions:-------------------------------------------------------------------
  @action
  void setErrorMessage(String message) {
    this.errorMessage = message;
  }

  @action
  void reset(String value) {
    print('calling reset');
    errorMessage = '';
  }

  // dispose:-------------------------------------------------------------------
  @action
  dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
