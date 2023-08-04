import 'package:flutter/foundation.dart';

/// 상태관리 방법 3: ValueNotifier
/// ValueNotifier = 1개의 value에 대한 ChangeNotifier
final videoConfig = ValueNotifier(false);

final isDarkMode = ValueNotifier(false);
