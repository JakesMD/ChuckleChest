import 'package:flutter/material.dart';

/// {@template CScrollToBottomFAB}
///
/// A floating action button that scrolls the user to the bottom of a scroll
/// view.
///
/// {@endtemplate}
class CScrollToBottomFAB extends StatefulWidget {
  /// {@macro CScrollToBottomFAB}
  const CScrollToBottomFAB({
    required this.scrollController,
    super.key,
  });

  /// The controller of the scroll view.
  final ScrollController scrollController;

  @override
  State<CScrollToBottomFAB> createState() => _CScrollToBottomFABState();
}

class _CScrollToBottomFABState extends State<CScrollToBottomFAB> {
  bool isAtBottom = true;

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(() {
      if (widget.scrollController.position.pixels !=
          widget.scrollController.position.maxScrollExtent) {
        if (isAtBottom) {
          setState(() => isAtBottom = false);
        }
      } else if (!isAtBottom) {
        setState(() => isAtBottom = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: RotationTransition(
          turns: Tween<double>(begin: 0.75, end: 1).animate(animation),
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        ),
      ),
      duration: const Duration(milliseconds: 150),
      child: !isAtBottom
          ? FloatingActionButton.small(
              key: const Key('fab'),
              onPressed: () => widget.scrollController.animateTo(
                widget.scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
              ),
              child: const Icon(Icons.arrow_downward_rounded),
            )
          : const SizedBox.shrink(key: Key('no_fab')),
    );
  }
}
