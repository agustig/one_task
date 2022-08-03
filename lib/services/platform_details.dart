import 'package:flutter/foundation.dart';

class PlatformDetails {
  bool get isIos => defaultTargetPlatform == TargetPlatform.iOS;
}
