import 'dart:async';

import 'package:flutter/material.dart';
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
  ThemeMode currentTheme = ThemeMode.light;

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

    if (cachedProfile != null) {
      //register the subscribtion
      _profileSubscription = (await _profileRepository.subscribeTo([
        WhereClause.greaterThan(
            fieldName: 'lastUpdated', value: cachedProfile.lastUpdated)
      ]))
          .listen((profiles) {
        if (profiles.isNotEmpty) {
          updateProfileUi(profiles.first);
        }
      });
    }
  }

  void signOutUser() async {
    state = SignOutLoading();
    final result = await _profileRepository.signOut();
    result.fold(
      (failure) => state = SignOutError(),
      (status) => state = SignOutLoaded(status),
    );
  }

  void updateProfileUi(ProfileModel? profileModel) {
    state = ProfileLoaded(
      status: profileModel == null ? false : true,
      profileModel: profileModel,
    );
  }

  void changetheme(ThemeMode theme) async {
    currentTheme = theme;
    state = ProfileLoaded(
        status: true,
        profileModel: await _profileRepository.getCachedProfile());
  }

  void unsubscribeProfile() {
    _profileSubscription?.cancel();
  }
}
