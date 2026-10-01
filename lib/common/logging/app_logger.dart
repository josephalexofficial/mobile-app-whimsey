import 'package:flutter/foundation.dart';

/// Debug-only logger. Production builds stay silent, and secrets are never written.
class AppLogger {
  const AppLogger._();

  static void error(String message, {String? errorCode}) {
    if (!kDebugMode) {
      return;
    }

    final code = errorCode ?? 'UNKNOWN';
    debugPrint('[ERROR] $message code=$code');
  }
}
