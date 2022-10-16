import 'dart:developer';

import 'package:fwc_album_app/app/models/register_user_model.dart';
import 'package:fwc_album_app/app/pages/auth/register/presenter/register_presenter.dart';
import 'package:fwc_album_app/app/repository/auth/auth_repository.dart';

import '../view/register_view.dart';

class RegisterPresenterImpl implements RegisterPresenter {
  final AuthRepository authRepository;
  late final RegisterView _view;

  RegisterPresenterImpl({required this.authRepository});

  @override
  Future<void> register(
      {required String name,
      required String email,
      required String password,
      required String confirmpassword}) async {
    final registerUserModel = RegisterUserModel(
        name: name,
        email: email,
        password: password,
        confirmpassword: confirmpassword);
    try {
      await authRepository.register(registerUserModel);
      _view.registerSucess();
    } on Exception catch (e, s) {
      log('Erro ao cadastra usuário', error: e, stackTrace: s);
      _view.registerEror();
    }
  }

  @override
  set view(RegisterView view) => _view = view;
}
