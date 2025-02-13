import 'package:chuckle_chest/shared/logic/_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CAppBarLoadingIndicator}
///
/// Displays a loading indicator below the app bar.
///
/// {@endtemplate}
class CAppBarLoadingIndicator extends StatefulWidget
    implements PreferredSizeWidget {
  /// {@macro CAppBarLoadingIndicator}
  const CAppBarLoadingIndicator({
    required this.listeners,
    super.key,
  });

  /// The list of loading listeners.
  // ignore: strict_raw_type
  final List<CLoadingListener> listeners;

  @override
  Size get preferredSize => const Size.fromHeight(4);

  @override
  State<CAppBarLoadingIndicator> createState() =>
      _CAppBarLoadingIndicatorState();
}

class _CAppBarLoadingIndicatorState extends State<CAppBarLoadingIndicator> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        for (final listener in widget.listeners)
          listener.buildListener(
            (isLoading) => setState(() => this.isLoading = isLoading),
          ),
      ],
      child: Visibility(
        visible: isLoading,
        child: const LinearProgressIndicator(minHeight: 4),
      ),
    );
  }
}

/// {@template CLoadingListener}
///
/// A listener for loading states for the [CAppBarLoadingIndicator].
///
/// {@endtemplate}
class CLoadingListener<B extends StateStreamable<S>, S> {
  /// {@macro CLoadingListener}
  CLoadingListener({this.isLoading});

  /// Whether the given state is the loading state.
  final bool Function(S state)? isLoading;

  /// Builds the bloc listener for the [CAppBarLoadingIndicator].
  BlocListener<B, S> buildListener(
    // Avoid because this is fed directly into a widget property.
    // ignore: avoid_positional_boolean_parameters
    void Function(bool isLoading) toggleLoading,
  ) {
    return BlocListener<B, S>(
      listener: (context, state) => toggleLoading(
        isLoading != null
            ? isLoading!(state)
            : (state as CRequestCubitState).inProgress,
      ),
    );
  }
}
