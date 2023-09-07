import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/view_models/timeline_view_model.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  int _itemCount = 0;
  final PageController _pageController = PageController();
  final _scrollDuration = const Duration(milliseconds: 250);
  final _scrollCurve = Curves.linear;

  List<Color> colors = [Colors.blue, Colors.yellow, Colors.pink, Colors.teal];

  void _onPageChanged(int page) {
    print("onPagechanges: $page");
    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );

    if (page == _itemCount - 1) {
      ref.watch(timelineProvider.notifier).fetchNextPage();
    }
  }

  void _onVideoFinished() {
    print("onVideoFinished");
    _pageController.nextPage(duration: _scrollDuration, curve: _scrollCurve);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    return ref.watch(timelineProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(timelineProvider).when(
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
        error: (error, stackTrace) => Center(
              child: Text(
                "Could not load video: $error",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
        data: (videos) {
          _itemCount = videos.length;
          return RefreshIndicator(
            displacement: 20,
            edgeOffset: 50,
            strokeWidth: 5,
            backgroundColor: Colors.red,
            color: Colors.blue,
            onRefresh: _onRefresh,
            child: PageView.builder(
              // pageSnapping: false,
              controller: _pageController,
              onPageChanged: _onPageChanged,
              scrollDirection: Axis.vertical,
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final videoData = videos[index];
                print("index: $index");
                return VideoPost(
                  onVideoFinished: _onVideoFinished,
                  index: index,
                  videoData: videoData,
                );
              },
            ),
          );
        });
  }
}
