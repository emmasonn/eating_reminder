import 'package:informat/feature/profile/domain/profile_model.dart';

class AuthState {
  const AuthState();
  factory AuthState.initial() => const AuthState();
}

class AuthLoaded extends AuthState {
  final ProfileModel? profileModel;
  final String? error;

  const AuthLoaded({
    this.profileModel,
    this.error,
  });
}
