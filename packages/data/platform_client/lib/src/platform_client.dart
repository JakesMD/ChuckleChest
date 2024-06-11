import 'package:ccore/ccore.dart';
import 'package:cplatform_client/cplatform_client.dart';
import 'package:cpub/share_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// A client to interact with the platform's API.
class CPlatformClient {
  /// Copies the given [text] to the clipboard.
  CJob<CClipboardCopyException, CNothing> copyToClipboard({
    required String text,
  }) =>
      CJob.attempt(
        run: () async {
          await Clipboard.setData(ClipboardData(text: text));
          return cNothing;
        },
        onError: CClipboardCopyException.fromError,
      );

  /// Shares the given [text] and [subject] at the given [sharePositionOrigin].

  CJob<CShareException, CNothing> share({
    required String text,
    required String subject,
    required Rect sharePositionOrigin,
  }) =>
      CJob.attempt(
        run: () async {
          await Share.share(
            text,
            subject: subject,
            sharePositionOrigin: sharePositionOrigin,
          );
          return cNothing;
        },
        onError: CShareException.fromError,
      );

  /// The operating system the app is running on.
  static COperatingSystem get operatingSystem {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return COperatingSystem.android;
      case TargetPlatform.iOS:
        return COperatingSystem.iOS;
      case TargetPlatform.linux:
        return COperatingSystem.linux;
      case TargetPlatform.macOS:
        return COperatingSystem.macOS;
      case TargetPlatform.windows:
        return COperatingSystem.windows;
      case TargetPlatform.fuchsia:
        return COperatingSystem.fuchsia;
    }
  }

  /// The type of device the app is running on.
  static CDeviceType get staticDeviceType {
    if (CPlatformClient.operatingSystem == COperatingSystem.android ||
        CPlatformClient.operatingSystem == COperatingSystem.iOS) {
      if (kIsWeb) return CDeviceType.mobileWeb;
      return CDeviceType.mobile;
    } else {
      if (kIsWeb) return CDeviceType.desktopWeb;
      return CDeviceType.desktop;
    }
  }

  /// The type of device the app is running on.
  CDeviceType get deviceType => CPlatformClient.staticDeviceType;
}
