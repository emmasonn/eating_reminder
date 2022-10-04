import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:informat/feature/Auth/managers/auth_state.dart';
import 'package:informat/feature/Auth/repository/auth_repository.dart';
import 'package:informat/feature/profile/domain/profile_model.dart';

class AuthManager extends StateNotifier<AuthState> {
  AuthManager({required this.authRepository}) : super(AuthState.initial());
  final AuthRepository authRepository;

  void loginWithGoogle() async {
    final result = await authRepository.loginWithGoogle();
    result.fold((error) {
      state = AuthLoaded(error: error.message);
    }, (profile) => updateAuthUi(profile));
  }

  void updateAuthUi(ProfileModel? profile) {
    state = AuthLoaded(profileModel: profile);
  }
}
