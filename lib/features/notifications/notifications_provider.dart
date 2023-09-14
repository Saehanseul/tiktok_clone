import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/inbox/screens/chats_screen.dart';
import 'package:tiktok_clone/features/videos/views/screens/video_recording_screen.dart';

class NotificationsProvider extends FamilyAsyncNotifier<void, BuildContext> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  FutureOr build(BuildContext context) async {
    final token = await _messaging.getToken();
    if (token == null) return;
    await updateToken(token);
    await initListeners(context);
    _messaging.onTokenRefresh.listen((newToken) async {
      await updateToken(newToken);
    });
  }

  Future<void> initListeners(BuildContext context) async {
    final permission = await _messaging.requestPermission();
    if (permission.authorizationStatus == AuthorizationStatus.denied) return;

    //Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print('onMessage: $event');
      print(event.notification?.title);
    });

    //Background
    FirebaseMessaging.onMessageOpenedApp.listen((notification) {
      print("onMessageOpenedApp: ${notification.data['screen']}");
      context.pushNamed(ChatsScreen.routeName);
    });

    //Terminated
    final notification = await _messaging.getInitialMessage();
    if (notification != null) {
      print("getInitialMessage: ${notification.data['screen']}");
      context.pushNamed(VideoRecordingScreen.routeName);
    }
  }

  Future<void> updateToken(String token) async {
    final user = ref.read(authRepo).user;
    if (user == null) return;

    await _db.collection('users').doc(user.uid).update({
      'token': token,
    });
  }
}

final notificationsProvider = AsyncNotifierProvider.family(
  () => NotificationsProvider(),
);
