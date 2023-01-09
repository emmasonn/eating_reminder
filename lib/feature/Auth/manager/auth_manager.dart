import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:informat/feature/Auth/manager/auth_state.dart';
import 'package:informat/feature/Auth/repository/auth_repository.dart';
import 'package:informat/feature/what_to_eat/managers/food_manager.dart';

class AuthManager extends StateNotifier<AuthState> {
  AuthManager({
    required this.authRepository,
    required this.foodManager,
  }) : super(AuthState.initial());
  final AuthRepository authRepository;
  final FoodManager foodManager;

  void loginWithGoogle() async {
    final result = await authRepository.loginWithGoogle();
    result.fold((error) {
      state = AuthLoaded(error: error.message);
    }, (profile) {
      state = const AuthLoaded(status: true);
    });
  }

  void loginEmail(String email, String password) async {
    state = AuthLoading();
    final result = await authRepository.loginWithEmail(email, password);
    result.fold(
      (failure) {
        state = AuthError(failure.message);
      },
      (status) {
        // state = AuthLoaded(status: status);
      },
    );
  }

  //Return true or false if the profile has been setup
  //by user to then navigator.
  void registerEmail(String email, String password) async {
    state = AuthLoading();
    final result = await authRepository.registerEmail(email, password);
    result.fold(
      (failure) {
        state = AuthError(failure.message);
      },
      (status) {
        // state = AuthLoaded(status: status);
      },
    );
  }
}
