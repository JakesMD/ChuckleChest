import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/pages/gem/bloc/_bloc.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CCollectionView}
///
/// The view that fetches and displays the gems with the given [gemIDs].
///
/// {@endtemplate}
class CCollectionView extends StatefulWidget {
  /// {@macro CCollectionView}
  const CCollectionView({
    required this.gemIDs,
    super.key,
  });

  /// The IDs of the gems to display.
  final List<String> gemIDs;

  @override
  State<CCollectionView> createState() => _CCollectionViewState();
}

class _CCollectionViewState extends State<CCollectionView> {
  final vistedIndexes = <int>{};

  @override
  void initState() {
    super.initState();
    if (widget.gemIDs.isNotEmpty) onPageChanged(0);
  }

  void onPageChanged(int index) {
    if (vistedIndexes.contains(index)) return;
    context
        .read<CGemFetchBloc>()
        .add(CGemFetchRequested(gemID: widget.gemIDs[index]));
    vistedIndexes.add(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        context: context,
        title: BlocBuilder<CGemFetchBloc, CGemFetchState>(
          builder: (context, state) => Text(
            state is CGemFetchSuccess ? state.gem.number.toString() : '',
          ),
        ),
        actions: [
          BlocBuilder<CGemFetchBloc, CGemFetchState>(
            builder: (context, state) => state is CGemFetchSuccess
                ? IconButton(
                    icon: const Icon(Icons.edit_rounded),
                    onPressed: () => context.router.push(
                      CEditGemRoute(gem: state.gem),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
      body: PageView.builder(
        onPageChanged: onPageChanged,
        itemCount: widget.gemIDs.length,
        itemBuilder: (context, index) =>
            BlocBuilder<CGemFetchBloc, CGemFetchState>(
          buildWhen: (previous, current) =>
              current.gemID == widget.gemIDs[index],
          builder: (context, state) => switch (state) {
            CGemFetchInitial() =>
              const Center(child: CCradleLoadingIndicator()),
            CGemFetchInProgress() =>
              const Center(child: CCradleLoadingIndicator()),
            CGemFetchFailure() =>
              const Center(child: Icon(Icons.error_rounded)),
            CGemFetchSuccess(gem: final gem) => CAnimatedGem(gem: gem),
          },
        ),
      ),
    );
  }
}
