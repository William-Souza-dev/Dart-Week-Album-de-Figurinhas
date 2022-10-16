import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:fwc_album_app/app/core/exceptions/repository_exceptions.dart';
import 'package:fwc_album_app/app/core/exceptions/unauthhorized_exception.dart';
import 'package:fwc_album_app/app/core/rest/custom_dio.dart';
import 'package:fwc_album_app/app/models/register_user_model.dart';
import 'package:fwc_album_app/app/repository/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio dio;

  AuthRepositoryImpl({required this.dio});

  @override
  Future<String> login(
      {required String email, required String password}) async {
    try {
      final result = await dio.post('/api/auth', data: {
        'email': email,
        'password': password,
      });
      final accessToken = result.data['access_token'];
      if (accessToken == null) {
        throw UnauthhorizedException();
      }
      return accessToken;
    } on DioError catch (e, s) {
      log('Erro ao relizar o login', error: e, stackTrace: s);
      if (e.response?.statusCode == 401) {
        throw UnauthhorizedException();
      }
      throw RepositoryExceptions(message: 'Erro ao realizar login');
    }
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }

  @override
  Future<void> register(RegisterUserModel registerModel) async {
    try {
      await dio.auth().post(
            '/api/register',
            data: registerModel.toMap(),
          );
    } on DioError catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      throw RepositoryExceptions(message: 'Erro ao registrar usuário');
    }
  }
}
