import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;
  final PageController _pageController = PageController();
  final _scrollDuration = const Duration(milliseconds: 150);
  final _scrollCurve = Curves.linear;

  List<Color> colors = [Colors.blue, Colors.yellow, Colors.pink, Colors.teal];

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );

    if (page == _itemCount - 1) {
      setState(() {
        _itemCount = _itemCount + 4;
        colors.addAll([
          Colors.blue,
          Colors.yellow,
          Colors.pink,
          Colors.teal,
        ]);
      });
    }
  }

  void _onVideoFinished() {
    _pageController.nextPage(duration: _scrollDuration, curve: _scrollCurve);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      // pageSnapping: false,
      controller: _pageController,
      onPageChanged: _onPageChanged,
      scrollDirection: Axis.vertical,
      itemCount: _itemCount,
      itemBuilder: (context, index) =>
          const VideoPost(onVideoFinished: _onVideoFinished),
    );
  }
}
