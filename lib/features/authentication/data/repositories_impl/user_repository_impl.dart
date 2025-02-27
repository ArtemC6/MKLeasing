import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:leasing_company/api/SignService.dart';
import 'package:leasing_company/api/UserService.dart';
import 'package:leasing_company/features/authentication/domain/models/user_model.dart';
import 'package:leasing_company/features/authentication/domain/models/user_repository_response_models.dart';
import 'package:leasing_company/features/authentication/domain/repositories/user_repository.dart';

import '../../../../main.dart';

class UserRepositoryImpl implements UserRepository{
  final UserService userService;
  final SignService signService;

  Box? appBox;

  UserRepositoryImpl(this.userService, this.signService);

  Future<LoginResponse> login(String phone, String password) async {
    final response = await signService.signin(phone, password);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return SuccessLoginResponse(
          json['access_token'], User.fromJson(json['user']));
    }
    if (response.statusCode == 422) {
      final json = jsonDecode(response.body);
      var validationFailedLoginResponse = ValidationFailedLoginResponse();
      validationFailedLoginResponse.errors = json['errors'];
      return validationFailedLoginResponse;
    }
    throw Exception();
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    appBox = getIt.get(instanceName: 'AppBox');
    appBox?.put('accessToken', token);
    return;
  }

  Future<void> setToken() async {
    await userService.setToken();
  }

  Future<bool> hasToken() async {
    appBox = getIt.get(instanceName: 'AppBox');
    final String? token = appBox?.get('accessToken');
    return token != null;
  }

  Future<bool> checkToken() async {
    final response = await userService.me();
    return response.statusCode == 200;
  }

  Future<MeResponse> me() async {
    final response = await userService.me();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return SuccessMeResponse(User.fromJson(json));
    } else {
      return FailureMeResponse();
    }
  }

  Future<void> saveUser(User user) async {
    appBox = getIt.get(instanceName: 'AppBox');
    await appBox?.put('user', user.toJson());
  }

  Future<User?> getUser() async {
    appBox = getIt.get(instanceName: 'AppBox');
    dynamic json = await appBox?.get('user', defaultValue: null);
    if (json == null) {
      return null;
    }
    return User.fromJson(json);
  }

  Future<RecoverySmsResponse> recoverySms(String phone) async {
    final response = await signService.resetPassword(phone);
    if (response.statusCode == 202) {
      return SuccessRecoverySmsResponse();
    }
    if (response.statusCode == 422) {
      final json = jsonDecode(response.body);
      var validationFailedRecoverySmsResponse =
          ValidationFailedRecoverySmsResponse();
      validationFailedRecoverySmsResponse.errors = json['errors'];
      return validationFailedRecoverySmsResponse;
    }
    throw Exception();
  }
}
