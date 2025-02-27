import 'package:leasing_company/features/authentication/domain/models/user_model.dart';
import 'package:leasing_company/features/authentication/domain/models/user_repository_response_models.dart';

abstract class UserRepository {
  Future<LoginResponse> login(String phone, String password);

  Future<void> deleteToken();

  Future<void> persistToken(String token);

  Future<void> setToken();

  Future<bool> hasToken();

  Future<bool> checkToken();

  Future<MeResponse> me();

  Future<void> saveUser(User user);

  Future<User?> getUser();

  Future<RecoverySmsResponse> recoverySms(String phone);
}
