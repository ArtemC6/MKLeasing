import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/config/models/config_model.dart';
import 'package:leasing_company/core/config/repositories/config_repository.dart';
import 'package:leasing_company/features/authentication/domain/models/user_repository_response_models.dart';
import 'package:leasing_company/features/authentication/domain/repositories/user_repository.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_event.dart';
import 'login_state.dart';

const LAST_REVIEWED_APP_VERSION = 'LAST_REVIEWED_APP_VERSION';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  final ConfigRepository _configRepository;

  LoginBloc({
    required UserRepository userRepository,
    required ConfigRepository configRepository,
  })  : _userRepository = userRepository,
        _configRepository = configRepository,
        super(LoginReadyState()) {
    on<LoginButtonPressedEvent>(_mapLoginButtonPressedToState);
    on<RegistrationButtonPressedEvent>(_mapRegistrationButtonPressedToState);
  }

  Future<void> _mapLoginButtonPressedToState(
      LoginButtonPressedEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginInProgressState());

      final sp = getIt<SharedPreferences>();

      final latestVerifiedVersion = await sp.getInt(LAST_REVIEWED_APP_VERSION);
      final packageInfo = await PackageInfo.fromPlatform();
      final buildNumber = int.parse(packageInfo.buildNumber);

      if (event.phone == '+79001001010'
          && latestVerifiedVersion != null
          && latestVerifiedVersion >= buildNumber
      ) {
        final map = Map<String, List>();
        map['phone'] = [S.of(event.context).accountDoesNotExist];
        emit(LoginValidationFailureState(map));
        return;
      }

      LoginResponse loginResponse =
          await _userRepository.login(event.phone, event.password);
      if (loginResponse is SuccessLoginResponse) {
        await _userRepository.persistToken(loginResponse.token);
        await _userRepository.setToken();
        var user = await _userRepository.getUser();
        if (user?.id != loginResponse.user.id) {
          await _userRepository.saveUser(loginResponse.user);
        }
        sp.setInt(LAST_REVIEWED_APP_VERSION, buildNumber);
        emit(LoginSuccessState());
      }
      if (loginResponse is ValidationFailedLoginResponse) {
        emit(LoginValidationFailureState(loginResponse.errors));
      }
    } catch (exception, stackTrace) {
      print(exception);
      print(stackTrace);
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(LoginErrorState());
    }
  }

  Future<void> _mapRegistrationButtonPressedToState(
      RegistrationButtonPressedEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginInProgressState());
      Config config = await _configRepository.get();
      emit(RegistrationSuccessState(config.multiCompanyMode));
    } catch (exception, stackTrace) {
      print(exception);
      print(stackTrace);
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(LoginErrorState());
    }
  }
}
