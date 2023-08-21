import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/onboarding/screens/interests_screen.dart';
import 'package:tiktok_clone/utils.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);

    // guard가 loading 없애는걸 대신 해줌 / 에러 처리도 해줌
    state = await AsyncValue.guard(() async =>
        await _authRepo.emailSignUp(form["email"]!, form["password"]!));

    if (state.hasError) {
      showFirebaseErrorSnack(context, state.hasError);
    } else {
      context.goNamed(InterestsScreen.routeName);
    }
  }
}

final signUpForm = StateProvider<Map<String, String>>((ref) {
  return {};
});

final SignUpProvider =
    AsyncNotifierProvider<SignUpViewModel, void>(() => SignUpViewModel());
