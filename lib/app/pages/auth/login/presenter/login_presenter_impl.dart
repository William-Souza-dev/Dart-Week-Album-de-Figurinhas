import 'dart:developer';

import 'package:fwc_album_app/app/core/exceptions/unauthhorized_exception.dart';
import 'package:fwc_album_app/app/pages/auth/login/presenter/login_presenter.dart';
import 'package:fwc_album_app/app/pages/auth/login/view/login_view.dart';
import 'package:fwc_album_app/app/services/login_service.dart';

class LoginPresenterImpl implements LoginPresenter {
  final LoginService loginService;
  late final LoginView _view;

  LoginPresenterImpl({
    required this.loginService,
  });

  @override
  Future<void> login(String email, String password) async {
    try {
      await loginService.execute(email: email, password: password);
      _view.success();
    } on UnauthhorizedException {
      _view.error('Usuario ou senha inválidos');
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      _view.error('Erro ao relizar login');
    }
  }

  @override
  set view(LoginView view) => _view = view;
}
