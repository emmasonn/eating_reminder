import 'package:informat/feature/profile/domain/profile_model.dart';

class AuthState {
  const AuthState();
  factory AuthState.initial() => const AuthState();
}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final bool? status;
  final ProfileModel? profileModel;
  final String? error;

  const AuthLoaded({
    this.status,
    this.profileModel,
    this.error,
  });
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
