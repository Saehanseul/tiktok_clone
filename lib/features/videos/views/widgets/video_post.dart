import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_comments.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final VideoModel videoData;

  final int index;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
    required this.videoData,
  });

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video1.mp4");
  final Duration _animationDuration = const Duration(milliseconds: 200);
  late final AnimationController _animationController;

  bool _isPaused = false;

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
    }
    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();

/*     /// 상태관리 방법 3: ValueNotifier
    videoConfig.addListener(() {
      setState(() {
        _autoMute = videoConfig.value;
      });
    }); */

    /* /// 상태관리 방법 2: ChangeNotifier
    videoConfig.addListener(() {
      setState(() {
        _autoMute = videoConfig.autoMute;
      });
    }); */

    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5, // 시작 값
      duration: _animationDuration,
    );

    /**
     * 애니메이션 방법 1
     * Transform.scale에 변하는 애니메이션의 값을 setState하면서 build계속 실행
     * 지금은 방법 2를 사용 => AnimatedBuilder widget 사용
     */
    // _animationController.addListener(() {
    //   setState(() {});
    // });

    /* /// 상태관리 방법 5: Provider + MVVM
    context
        .read<PlaybackConfigViewModel>()
        .addListener(_onPlaybackConfigChanged); */
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _onPlaybackConfigChanged() async {
    if (!mounted) return;

    /* /// 상태관리 방법 5: Provider + MVVM
    final muted = context.read<PlaybackConfigViewModel>().muted; */

    if (ref.read(playbackConfigProvider).muted) {
      await _videoPlayerController.setVolume(0);
    } else {
      await _videoPlayerController.setVolume(1);
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      //설정에 autoplay가 켜져 있을때만 실행

      /* /// 상태관리 방법 5: Provider + MVVM
      final autoplay = context.read<PlaybackConfigViewModel>().autoplay; */

      if (ref.read(playbackConfigProvider).autoplay) {
        _videoPlayerController.play();
      }
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse(); // upper => lower
    } else {
      _videoPlayerController.play();
      _animationController.forward(); // lower => upper
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const VideoComments(),
      backgroundColor: Colors.transparent,
    );
    _onTogglePause();
  }

  @override
  Widget build(BuildContext context) {
    /* /// 상태관리 방법 1
    VideoConfigData.of(context).autoMute;
    /// VideoConfig에 아래 내용을 of로 만들면 직접 쓸 필요 없이 위 처럼 of로 접근 가능
    final videoConfig =
        context.dependOnInheritedWidgetOfExactType<VideoConfig>(); */
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          // Position은 언제나 Stack의 child여야 함. 상위에 다른 widget으로 감싸면 안됨???
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : false
                    ? Image.network(widget.videoData.thumbnailUrl,
                        fit: BoxFit.cover)
                    : Container(),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                        scale: _animationController.value, child: child);
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            child: IconButton(
              onPressed: () async {
                // print("volumn change");

                ref
                    .read(playbackConfigProvider.notifier)
                    .setMuted(!ref.read(playbackConfigProvider).muted);
                await _onPlaybackConfigChanged();
                /* /// 상태관리 방법 5: Provider + MVVM
                context
                    .read<PlaybackConfigViewModel>()
                    .setMuted(!context.read<PlaybackConfigViewModel>().muted); */
              },
              icon: FaIcon(
                /* /// 상태관리 방법 5: Provider + MVVM
                context.watch<PlaybackConfigViewModel>().muted */
                ref.watch(playbackConfigProvider).muted
                    ? FontAwesomeIcons.volumeOff
                    : FontAwesomeIcons.volumeHigh,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@${widget.videoData.creator}",
                  style: const TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Row(children: [
                  SizedBox(
                    width: 300,
                    child: Text(
                      widget.videoData.description,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: Sizes.size16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ])
              ],
            ),
          ),

          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.blue,
                  foregroundImage: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/tiktok-31seul.appspot.com/o/avatars%2F${widget.videoData.creatorUid}?alt=media",
                  ),
                  radius: 25,
                  child: Text("@${widget.videoData.creator}"),
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: S.of(context).likeCount(widget.videoData.likes),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: S.of(context).commentCount(2300),
                  ),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "Share",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
