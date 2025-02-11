import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cplatform_client/cplatform_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

/// A client to interact with the platform's API.
class CPlatformClient {
  /// Copies the given [text] to the clipboard.
  BobsJob<CClipboardCopyException, BobsNothing> copyToClipboard({
    required String text,
  }) =>
      BobsJob.attempt(
        run: () => Clipboard.setData(ClipboardData(text: text)),
        onError: CClipboardCopyException.fromError,
      ).thenConvertSuccess((_) => bobsNothing);

  /// Shares the given [text] and [subject] at the given [sharePositionOrigin].
  BobsJob<CShareException, BobsNothing> share({
    required String text,
    required String subject,
    required Rect sharePositionOrigin,
  }) =>
      BobsJob.attempt(
        run: () => Share.share(
          text,
          subject: subject,
          sharePositionOrigin: sharePositionOrigin,
        ),
        onError: CShareException.fromError,
      ).thenConvertSuccess((_) => bobsNothing);

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

  /// Allows the user to pick an image from their gallery.
  BobsJob<CImagePickException, BobsMaybe<Uint8List>> pickImage({
    double? maxWidth,
    double? maxHeight,
  }) =>
      BobsJob.attempt(
        run: () => ImagePicker().pickImage(
          source: ImageSource.gallery,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
        ),
        onError: CImagePickException.fromError,
      ).thenConvertSuccess(bobsMaybe).thenAttempt(
            run: (image) => image.resolve(
              onPresent: (data) async {
                final bytes = await data.readAsBytes();
                return bobsPresent(bytes);
              },
              onAbsent: bobsAbsent,
            ),
            onError: CImagePickException.fromError,
          );
}
