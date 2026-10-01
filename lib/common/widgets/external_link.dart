import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../logging/app_logger.dart';

/// Opens a public http, mailto, or tel link in the platform handler.
Future<void> openExternalUri(BuildContext context, String rawUrl) async {
  final uri = Uri.tryParse(rawUrl.trim());
  if (uri == null || uri.scheme.isEmpty) {
    _reportLinkFailure(context);
    return;
  }

  try {
    final didLaunch = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!didLaunch && context.mounted) {
      _reportLinkFailure(context);
    }
  } on Exception {
    AppLogger.error('External link could not be opened.', errorCode: 'LINK_LAUNCH_FAILED');
    if (context.mounted) {
      _reportLinkFailure(context);
    }
  }
}

void _reportLinkFailure(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('This link could not be opened on this device.')),
  );
}
