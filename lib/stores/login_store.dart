import 'dart:ui';

import 'package:mobx/mobx.dart';
import 'package:validators2/validators.dart';

part 'login_store.g.dart';

class CustomColor extends Color {
  CustomColor(int value) : super(value);
}

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  final FormErrorState error = FormErrorState();

  @observable
  CustomColor color = CustomColor(0);

  @observable
  String username = '';

  @observable
  String password = '';

  @computed
  bool get canLogin => !error.hasErrors;

  @observable
  bool isLoading = false;

  late List<ReactionDisposer> _disposers;

  void setupValidations() {
    _disposers = [
      reaction((_) => username, validateUsername),
      reaction((_) => password, validatePassword)
    ];
  }

  @action
  void validateUsername(String value) {
    if (isNull(value) || value.isEmpty) {
      error.username = 'Cannot be blank';
      return;
    } else {
      error.username = null;
    }
  }

  @action
  void validatePassword(String value) {
    error.password = isNull(value) || value.isEmpty ? 'Cannot be blank' : null;
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validateUsername(username);
    validatePassword(password);
  }
}

class FormErrorState = _FormErrorState with _$FormErrorState;

abstract class _FormErrorState with Store {
  @observable
  String? username;

  @observable
  String? password;

  @computed
  bool get hasErrors => username != null || password != null;
}