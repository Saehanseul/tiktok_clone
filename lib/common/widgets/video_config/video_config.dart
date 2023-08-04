import 'package:flutter/foundation.dart';

/// 상태관리 방법 4: Provider
class VideoConofig extends ChangeNotifier {
  bool isMuted = false;
  bool isAutoplay = false;

  void toggleIsMuted() {
    isMuted = !isMuted;
    notifyListeners();
  }

  void toggleAutoplay() {
    isAutoplay = !isAutoplay;
    notifyListeners();
  }
}

final isDarkMode = ValueNotifier(false);
