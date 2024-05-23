import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Animates its own size and clips and aligns its child.
///
/// A custom variation on the [SizeTransition] widget that allows for a custom
/// clip behavior.
///
/// [CSizeTransition] acts as a [ClipRect] that animates either its width or its
/// height, depending upon the value of [axis]. The alignment of the child along
/// the [axis] is specified by the [axisAlignment].
///
/// Like most widgets, [CSizeTransition] will conform to the constraints it is
/// given, so be sure to put it in a context where it can change size. For
/// instance, if you place it into a [Container] with a fixed size, then the
/// [CSizeTransition] will not be able to change size, and will appear to do
/// nothing.
///
/// Here's an illustration of the [CSizeTransition] widget, with it's
/// [sizeFactor] animated by a [CurvedAnimation] set to [Curves.fastOutSlowIn]:
/// {@animation 300 378 https://flutter.github.io/assets-for-api-docs/assets/widgets/size_transition.mp4}
///
/// {@tool dartpad}
/// This code defines a widget that uses [CSizeTransition] to change the size
/// of [FlutterLogo] continually. It is built with a [Scaffold]
/// where the internal widget has space to change its size.
///
/// ** See code in examples/api/lib/widgets/transitions/size_transition.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedCrossFade], for a widget that automatically animates between
///    the sizes of two children, fading between them.
///  * [ScaleTransition], a widget that scales the size of the child instead of
///    clipping it.
///  * [PositionedTransition], a widget that animates its child from a start
///    position to an end position over the lifetime of the animation.
///  * [RelativePositionedTransition], a widget that transitions its child's
///    position based on the value of a rectangle relative to a bounding box.
class CSizeTransition extends AnimatedWidget {
  /// Creates a size transition.
  ///
  /// A custom variation on the [SizeTransition] widget that allows for a custom
  /// clip behavior.
  ///
  /// The [axis] argument defaults to [Axis.vertical]. The [axisAlignment]
  /// defaults to zero, which centers the child along the main axis during the
  /// transition.
  const CSizeTransition({
    required Animation<double> sizeFactor,
    this.axis = Axis.vertical,
    this.axisAlignment = 0.0,
    this.clipBehavior = Clip.hardEdge,
    this.fixedCrossAxisSizeFactor,
    this.child,
    super.key,
  })  : assert(
          fixedCrossAxisSizeFactor == null || fixedCrossAxisSizeFactor >= 0,
          'fixedCrossAxisSizeFactor must be null or non-negative',
        ),
        super(listenable: sizeFactor);

  /// [Axis.horizontal] if [sizeFactor] modifies the width, otherwise
  /// [Axis.vertical].
  final Axis axis;

  /// The animation that controls the (clipped) size of the child.
  ///
  /// The width or height (depending on the [axis] value) of this widget will be
  /// its intrinsic width or height multiplied by [sizeFactor]'s value at the
  /// current point in the animation.
  ///
  /// If the value of [sizeFactor] is less than one, the child will be clipped
  /// in the appropriate axis.
  Animation<double> get sizeFactor => listenable as Animation<double>;

  /// Describes how to align the child along the axis that [sizeFactor] is
  /// modifying.
  ///
  /// A value of -1.0 indicates the top when [axis] is [Axis.vertical], and the
  /// start when [axis] is [Axis.horizontal]. The start is on the left when the
  /// text direction in effect is [TextDirection.ltr] and on the right when it
  /// is [TextDirection.rtl].
  ///
  /// A value of 1.0 indicates the bottom or end, depending upon the [axis].
  ///
  /// A value of 0.0 (the default) indicates the center for either [axis] value.
  final double axisAlignment;

  /// The clip behavior of the child.
  final Clip clipBehavior;

  /// The factor by which to multiply the cross axis size of the child.
  ///
  /// If the value of [fixedCrossAxisSizeFactor] is less than one, the child
  /// will be clipped along the appropriate axis.
  ///
  /// If `null` (the default), the cross axis size is as large as the parent.
  final double? fixedCrossAxisSizeFactor;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final AlignmentDirectional alignment;
    if (axis == Axis.vertical) {
      alignment = AlignmentDirectional(-1, axisAlignment);
    } else {
      alignment = AlignmentDirectional(axisAlignment, -1);
    }
    return ClipRect(
      clipBehavior: clipBehavior,
      child: Align(
        alignment: alignment,
        heightFactor: axis == Axis.vertical
            ? math.max(sizeFactor.value, 0)
            : fixedCrossAxisSizeFactor,
        widthFactor: axis == Axis.horizontal
            ? math.max(sizeFactor.value, 0)
            : fixedCrossAxisSizeFactor,
        child: child,
      ),
    );
  }
}
