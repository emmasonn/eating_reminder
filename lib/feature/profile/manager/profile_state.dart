import 'package:informat/feature/profile/domain/profile_model.dart';

class ProfileState {
  const ProfileState();
  factory ProfileState.initial() => const ProfileState();
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final bool status;
  final ProfileModel? profileModel;
  final String? error;

  const ProfileLoaded({
    required this.status,
     this.profileModel,
     this.error,
  });
}
