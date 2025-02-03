import 'package:auto_route/auto_route.dart';
import 'package:ccore/ccore.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CAnimatedGem}
///
/// A widget that displays an animated gem which is a funny conversation with
/// narration lines and quotes.
///
/// {@endtemplate}
class CAnimatedGem extends StatefulWidget {
  /// {@macro CAnimatedGem}
  const CAnimatedGem({
    required this.gem,
    required this.isLastGem,
    super.key,
  });

  /// The gem to display.
  final CGem gem;

  /// Whether to display the 'swipe to view next' message.
  final bool isLastGem;

  @override
  State<CAnimatedGem> createState() => _CAnimatedGemState();
}

class _CAnimatedGemState extends State<CAnimatedGem> with AutoRouteAware {
  AutoRouteObserver? observer;
  final scrollController = ScrollController();

  Key key = UniqueKey();

  int currentLineIndex = 0;

  bool showPullSwipeMessages = false;

  void onLineAnimationCompleted() {
    if (currentLineIndex == widget.gem.lines.length - 1) {
      setState(() => showPullSwipeMessages = true);
      return;
    }
    setState(() => currentLineIndex++);
  }

  Future<void> restart() async {
    setState(() {
      currentLineIndex = 0;
      showPullSwipeMessages = false;
      key = UniqueKey();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    observer = RouterScope.of(context).firstObserverOfType<AutoRouteObserver>();
    if (observer != null) observer!.subscribe(this, context.routeData);
  }

  @override
  void didPopNext() => restart();

  @override
  void dispose() {
    scrollController.dispose();
    observer?.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final people = <CPerson>[];

    if (widget.gem is CSharedGem) {
      people.addAll((widget.gem as CSharedGem).people);
    } else {
      people.addAll(context.read<CChestPeopleFetchCubit>().state.people);
    }

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
          padding: const EdgeInsets.symmetric(vertical: 16),
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
                      people: people,
                      occurredAt: widget.gem.occurredAt,
                      onAnimationCompleted: onLineAnimationCompleted,
                    ),
                  )
                  .toList(),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: showPullSwipeMessages ? 1 : 0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    '''${!widget.isLastGem ? '${context.cAppL10n.gem_swipeMessage} ' : ''}${context.cAppL10n.gem_restartMessage}''',
                    style: context.cTextTheme.labelMedium!
                        .copyWith(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
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
