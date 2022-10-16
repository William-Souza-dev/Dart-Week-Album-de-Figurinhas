import 'package:fwc_album_app/app/models/register_user_model.dart';

abstract class AuthRepository {
  Future<void> register(RegisterUserModel registerUserModel);

  Future<String> login({required String email, required String password});
  Future<void> logout();
}
