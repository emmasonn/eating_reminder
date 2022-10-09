import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:informat/feature/Auth/manager/auth_state.dart';
import 'package:informat/feature/Auth/repository/auth_repository.dart';
import 'package:informat/feature/profile/domain/profile_model.dart';
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
      foodManager.updateStatus(status: true);
      updateAuthUi(profile);
    });
  }

  void updateAuthUi(ProfileModel? profile) {
    state = AuthLoaded(profileModel: profile);
  }
}
