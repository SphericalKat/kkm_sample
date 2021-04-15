import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:validators2/validators.dart';

import '../models/api_response.dart';
import '../models/login/login_request.dart';
import '../models/login/login_response.dart';
import '../services/login_service.dart';
import '../utils/ui.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  final FormErrorState error = FormErrorState();

  static ObservableFuture<ApiResponse<LoginResponse>> emptyResponse =
  ObservableFuture.value(ApiResponse.empty());

  @observable
  String username = '';

  @observable
  String password = '';

  @computed
  bool get canLogin => !error.hasErrors;

  @observable
  bool isLoading = false;

  @observable
  ObservableFuture<ApiResponse<LoginResponse>> loginResponseFuture =
      emptyResponse;

  @observable
  ApiResponse<LoginResponse> loginResponse = ApiResponse.empty();

  late List<ReactionDisposer> _disposers;

  void setupValidations(BuildContext context) {
    _disposers = [
      reaction((_) => username, validateUsername),
      reaction((_) => password, validatePassword),
      reaction((_) => loginResponseFuture.status, setLoginResponse),
      reaction((_) => loginResponse, handleResponseChanged(context))
    ];
  }

  void Function(ApiResponse<LoginResponse>) handleResponseChanged(
      BuildContext context) {
    return (ApiResponse<LoginResponse> resp) {
      switch (resp.status) {
        case Status.EMPTY:
          break;
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          showSnackBar(context, 'Login successful!');
          break;
        case Status.ERROR:
          showSnackBar(context, resp.message.toString());
          break;
      }
    };
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

  @action
  Future doLogin(LoginRequest request) =>
      loginResponseFuture = ObservableFuture(LoginService.login(request));

  @action
  Future setLoginResponse(FutureStatus resp) async {
    if (resp == FutureStatus.pending) {
      isLoading = true;
    } else {
      isLoading = false;
    }

    if (resp == FutureStatus.fulfilled) {
      loginResponse = loginResponseFuture.value!;
    }
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void login(LoginRequest request) {
    doLogin(request);
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
