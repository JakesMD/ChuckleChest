import 'dart:developer';
import 'dart:io';

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
    if (kIsWeb) return COperatingSystem.web;

    switch (Platform.operatingSystem) {
      case 'android':
        return COperatingSystem.android;
      case 'ios':
        return COperatingSystem.ios;
      case 'linux':
        return COperatingSystem.linux;
      case 'macos':
        return COperatingSystem.macos;
      case 'windows':
        return COperatingSystem.windows;
      default:
        return COperatingSystem.unknown;
    }
  }

  /// The type of device the app is running on.
  ///
  /// This is not static for mocking purposes.
  CDeviceType get deviceType {
    if (kIsWeb) {
      return CDeviceType.web;
    } else if (Platform.isAndroid || Platform.isIOS) {
      return CDeviceType.mobile;
    } else {
      return CDeviceType.desktop;
    }
  }
}
