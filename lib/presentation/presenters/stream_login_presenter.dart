import 'dart:async';

import '../dependencies/validation.dart';

class LoginState {
  String? emailError;
  bool get isFormValid => false;
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();

  var _state = LoginState();

  StreamLoginPresenter({required this.validation});

  Stream<String?> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError).distinct();

  Stream<bool?> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  void validateEmail(String email) {
    validation.validate(field: 'email', value: email);
    _state.emailError = 'any error';
    _controller.add(_state);
  }
}