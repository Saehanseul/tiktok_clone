import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp() async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);

    state = await AsyncValue.guard(
        () async => await _authRepo.signUp(form["email"]!, form["password"]!));
  }
}

final signUpForm = StateProvider<Map<String, String>>((ref) {
  return {};
});

final SignUpProvider =
    AsyncNotifierProvider<SignUpViewModel, void>(() => SignUpViewModel());
