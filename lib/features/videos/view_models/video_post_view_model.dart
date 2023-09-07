import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

// FamilyAsyncNotifier는 추가인자를 보내게 해줌
class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideosRepository _repository;
  late final _videoId;

  @override
  FutureOr<void> build(String videoId) async {
    _repository = ref.read(videosRepo);
    _videoId = videoId;
  }

  Future<void> likeVideo() async {
    final user = ref.read(authRepo).user;
    await _repository.likeVideo(_videoId, user!.uid);
  }

  Future<bool> isLikedVideo() async {
    final user = ref.read(authRepo).user;
    return await _repository.isLikedVideo(_videoId, user!.uid);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
  () => VideoPostViewModel(),
);
