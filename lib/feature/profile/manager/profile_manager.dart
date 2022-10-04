import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:informat/core/firebase_services/firebase_util.dart';
import 'package:informat/feature/profile/domain/profile_model.dart';
import 'package:informat/feature/profile/manager/profile_state.dart';
import 'package:informat/feature/profile/repository/profile_repository.dart';

class ProfileManager extends StateNotifier<ProfileState> {
  ProfileManager(ProfileRepository profileRepository)
      : _profileRepository = profileRepository,
        super(ProfileState.initial());

  final ProfileRepository _profileRepository;
  StreamSubscription? _profileSubscription;

  void saveProfile(ProfileModel obj) async {
    final result = await _profileRepository.saveProfile(obj);
    result.fold(
      (error) {
        state = const ProfileLoaded(
          status: false,
        );
      },
      (profile) => state = ProfileLoaded(
        status: true,
        profileModel: profile,
      ),
    );
  }

  void subScribeToProfile() async {
    //get profile from database
    final cachedProfile = await _profileRepository.getCachedProfile();

    //update the ui with cached data
    updateProfileUi(cachedProfile);

    //register the subscribtion
    _profileSubscription = (await _profileRepository.subscribeTo([
      if (cachedProfile != null)
        WhereClause.greaterThan(
            fieldName: 'lastUpdated', value: cachedProfile.lastUpdated)
    ]))
        .listen((profile) {
      updateProfileUi(profile.first);
    });
  }

  void updateProfileUi(ProfileModel? profileModel) {
    state = ProfileLoaded(
      status: profileModel == null ? false : true,
      profileModel: profileModel,
    );
  }

  void unsubscribeProfile() {
    _profileSubscription?.cancel();
  }
}
