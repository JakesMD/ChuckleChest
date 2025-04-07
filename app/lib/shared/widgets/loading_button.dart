import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CLoadingButton}
///
/// A button that shows a loading indicator when the state is loading.
///
/// The button will be disabled when the state is loading.
///
/// {@endtemplate}
class CLoadingButton<B extends StateStreamable<S>, S> extends StatelessWidget {
  /// {@macro CLoadingButton}
  const CLoadingButton({
    required this.child,
    required this.onPressed,
    required this.builder,
    this.isSmall = false,
    this.isEnabled = true,
    this.isLoading,
    this.loadingIndicatorColor,
    super.key,
  });

  /// The text of the button.
  final Widget child;

  /// The function that will be called when the button is pressed.
  final void Function(BuildContext context, B bloc)? onPressed;

  /// The function that determines the bloc state is a loading state.
  final bool Function(S)? isLoading;

  /// The builder that will be used to build the button.
  final Widget Function(
    BuildContext context,
    Widget text,
    void Function()? onPressed,
  ) builder;

  /// Whether the button is small.
  final bool isSmall;

  /// Whether the button is enabled.
  final bool isEnabled;

  /// The color of the loading indicator.
  final Color? loadingIndicatorColor;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<B>();

    return BlocBuilder<B, S>(
      buildWhen: (previous, current) => isLoading != null
          ? isLoading!(previous) != isLoading!(current)
          : (current as CRequestCubitState).inProgress,
      builder: (context, state) {
        final isInProgress =
            isLoading?.call(state) ?? (state as CRequestCubitState).inProgress;

        return builder(
          context,
          Stack(
            children: [
              Opacity(
                opacity: isInProgress ? 0 : 1,
                child: Center(child: child),
              ),
              if (isInProgress)
                Positioned.fill(
                  child: Center(
                    child: LayoutBuilder(
                      builder: (context, constraints) => isSmall
                          ? CBouncyBallLoadingIndicator(
                              color: loadingIndicatorColor,
                              ballSize: constraints.maxHeight * 0.3,
                            )
                          : CCradleLoadingIndicator(
                              color: loadingIndicatorColor,
                              ballSize: constraints.maxHeight * 0.6,
                            ),
                    ),
                  ),
                ),
            ],
          ),
          !isInProgress && isEnabled
              ? () => onPressed?.call(context, bloc)
              : null,
        );
      },
    );
  }
}
