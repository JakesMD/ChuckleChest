import 'package:ccore/ccore.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/pages/gem/bloc/_bloc.dart';
import 'package:chuckle_chest/shared/physics/auto_scrolling.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CAnimatedGemView}
///
/// The view that fetches and displays the gem with the given [gemID].
///
/// {@endtemplate}
class CAnimatedGemView extends StatefulWidget {
  /// {@macro CAnimatedGemView}
  const CAnimatedGemView({
    required this.gemID,
    super.key,
  });

  /// The ID of the gem to display.
  final String gemID;

  @override
  State<CAnimatedGemView> createState() => _CAnimatedGemViewState();
}

class _CAnimatedGemViewState extends State<CAnimatedGemView> {
  @override
  void initState() {
    context.read<CGemFetchBloc>().add(CGemFetchRequested(gemID: widget.gemID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CGemFetchBloc, CGemFetchState>(
      buildWhen: (_, state) => state.gemID == widget.gemID,
      builder: (context, state) => Scaffold(
        body: switch (state) {
          CGemFetchInitial() => const Center(child: CCradleLoadingIndicator()),
          CGemFetchInProgress() =>
            const Center(child: CCradleLoadingIndicator()),
          CGemFetchFailure() => const Center(child: Icon(Icons.error_rounded)),
          CGemFetchSuccess(gem: final gem) => CAnimatedGem(gem: gem),
        },
      ),
    );
  }
}

/// {@template CAnimatedGem}
///
/// A widget that displays an animated gem.
///§
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

  Key key = UniqueKey();

  int currentLineIndex = 0;

  void onLineAnimationCompleted() {
    if (currentLineIndex == widget.gem.lines.length - 1) return;
    setState(() => currentLineIndex++);
  }

  Future<void> restart() async {
    setState(() {
      currentLineIndex = 0;
      key = UniqueKey();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lines = widget.gem.lines.isNotEmpty
        ? widget.gem.lines.sublist(0, currentLineIndex + 1)
        : <CLine>[];

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: restart,
        child: ListView(
          key: key,
          controller: scrollController,
          physics: const CAutoScrollingPhysics(
            parent: AlwaysScrollableScrollPhysics(),
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
                      onAnimationCompleted: onLineAnimationCompleted,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: _CScrollToBottomFAB(
        key: ValueKey('$key-fab'),
        scrollController: scrollController,
      ),
    );
  }
}

class _CScrollToBottomFAB extends StatefulWidget {
  const _CScrollToBottomFAB({required this.scrollController, super.key});

  final ScrollController scrollController;

  @override
  State<_CScrollToBottomFAB> createState() => __CScrollToBottomFABState();
}

class __CScrollToBottomFABState extends State<_CScrollToBottomFAB> {
  bool isAtBottom = true;

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(listener);
  }

  void listener() {
    if (widget.scrollController.position.pixels !=
        widget.scrollController.position.maxScrollExtent) {
      if (isAtBottom) {
        setState(() => isAtBottom = false);
      }
    } else if (!isAtBottom) {
      setState(() => isAtBottom = true);
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(listener);
    super.dispose();
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
