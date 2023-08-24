import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/users_repos.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _repository;

  @override
  FutureOr<UserProfileModel> build() {
    _repository = ref.read(UserRepo);
    return UserProfileModel.empty();
  }

  Future<void> createProfile(
      UserCredential credential, Map<String, dynamic> form) async {
    if (credential.user == null) {
      throw Exception("Profile not created");
    }

    state = const AsyncValue.loading();

    final profile = UserProfileModel(
      uid: credential.user!.uid,
      email: credential.user!.email ?? "anon@anon.com",
      name: form["name"] ?? "Anon",
      bio: form['birth'],
      link: "undefined",
    );

    await _repository.createProfile(profile);
    state = AsyncValue.data(profile);
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
