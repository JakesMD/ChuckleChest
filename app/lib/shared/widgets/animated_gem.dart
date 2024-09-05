import 'package:ccore/ccore.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/shared/physics/auto_scrolling.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:flutter/material.dart';

/// {@template CAnimatedGem}
///
/// A widget that displays an animated gem.
///
/// {@endtemplate}
class CAnimatedGem extends StatefulWidget {
  /// {@macro CAnimatedGem}
  const CAnimatedGem({required this.gem, super.key});

  /// The gem to display.
  final CGem gem;

  @override
  State<CAnimatedGem> createState() => _CAnimatedGemState();
}

class _CAnimatedGemState extends State<CAnimatedGem> {
  final scrollController = ScrollController();

  int currentLineIndex = 0;

  void onLineAnimationCompleted() {
    if (currentLineIndex == widget.gem.lines.length - 1) return;
    setState(() => currentLineIndex++);
  }

  @override
  Widget build(BuildContext context) {
    final lines = widget.gem.lines.sublist(0, currentLineIndex + 1);

    return Scaffold(
      body: ListView(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        physics: const CAutoScrollingPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: [
          CAnimatedTypingText(
            delay: Duration.zero,
            text: widget.gem.occurredAt.cLocalize(
              context,
              dateFormat: CDateFormat.yearMonth,
            ),
            textStyle: Theme.of(context).textTheme.labelMedium!,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: lines
                .map(
                  (line) => CAnimatedLine(
                    line: line,
                    occurredAt: widget.gem.occurredAt,
                  ),
                )
                .toList(),
          ),
        ],
      ),
      floatingActionButton:
          _CScrollToBottomFAB(scrollController: scrollController),
    );
  }
}

class _CScrollToBottomFAB extends StatefulWidget {
  const _CScrollToBottomFAB({required this.scrollController});

  final ScrollController scrollController;

  @override
  State<_CScrollToBottomFAB> createState() => __CScrollToBottomFABState();
}

class __CScrollToBottomFABState extends State<_CScrollToBottomFAB> {
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
