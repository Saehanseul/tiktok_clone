/* import 'package:flutter/foundation.dart';

/// 상태관리 방법 2: ChangeNotifier (+AnimatedBuilder or Listener)
/// 데이터가 많을 때 유리. autoMute처럼 데이터 하나만 관리하고 싶으면 valueNotifier가 더 나음
class VideoConfig extends ChangeNotifier {
  bool autoMute = true;

  void toggleAutoMute() {
    autoMute = !autoMute;

    /// autoMute value를 듣고 있는 모든 화면에 변경 사항을 전달
    /// 1. AnimatedBuilder를 사용해서 value를 읽고 있는 화면들
    /// 2. addListener로 듣고 있는 화면들
    notifyListeners();
  }
}

final videoConfig = VideoConfig();
 */