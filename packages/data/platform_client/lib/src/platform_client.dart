import 'dart:developer';

import 'package:cplatform_client/cplatform_client.dart';
import 'package:cpub/dartz.dart';
import 'package:cpub/share_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// A client to interact with the platform's API.
class CPlatformClient {
  /// Copies the given [text] to the clipboard.
  Future<Either<CClipboardCopyException, Unit>> copyToClipboard({
    required String text,
  }) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      return right(unit);
    } catch (e, s) {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CPlatformClient.copyToClipboard',
      );
      return left(CClipboardCopyException.unknown);
    }
  }

  /// Shares the given [text] and [subject] at the given [sharePositionOrigin].

  Future<Either<CShareException, Unit>> share({
    required String text,
    required String subject,
    required Rect sharePositionOrigin,
  }) async {
    try {
      await Share.share(
        text,
        subject: subject,
        sharePositionOrigin: sharePositionOrigin,
      );
      return right(unit);
    } catch (e, s) {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CPlatformClient.share',
      );
      return left(CShareException.unknown);
    }
  }

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
  static CDeviceType get deviceType {
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
  ///
  /// This is not static for mocking purposes.
  CDeviceType get notStaticDeviceType => CPlatformClient.deviceType;
}
