import 'package:flutter/widgets.dart';

/// {@template CAutoScrollingPhysics}
///
/// A scroll physics that automatically scrolls to the end of the list.
///
/// This physics is used to automatically scroll to the end of the list when new
/// items are added. However, it does not automatically scroll when not already
/// at the end.
///
/// {@endtemplate}
class CAutoScrollingPhysics extends ScrollPhysics {
  /// {@macro CAutoScrollingPhysics}
  const CAutoScrollingPhysics({super.parent});

  @override
  CAutoScrollingPhysics applyTo(ScrollPhysics? ancestor) {
    return CAutoScrollingPhysics(parent: buildParent(ancestor));
  }

  @override
  double adjustPositionForNewDimensions({
    required ScrollMetrics oldPosition,
    required ScrollMetrics newPosition,
    required bool isScrolling,
    required double velocity,
  }) {
    final position = super.adjustPositionForNewDimensions(
      oldPosition: oldPosition,
      newPosition: newPosition,
      isScrolling: isScrolling,
      velocity: velocity,
    );

    if (newPosition.pixels >= oldPosition.maxScrollExtent) {
      return newPosition.maxScrollExtent;
    }
    return position;
  }
}
