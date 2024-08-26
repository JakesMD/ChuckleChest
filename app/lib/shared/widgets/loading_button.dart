import 'package:chuckle_chest/shared/widgets/cradle_loading_indicator.dart';
import 'package:cpub/flutter_bloc.dart';
import 'package:flutter/widgets.dart';

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
    required this.text,
    required this.isLoading,
    required this.onPressed,
    required this.builder,
    this.loadingIndicatorColor,
    super.key,
  });

  /// The text of the button.
  final Widget text;

  /// The function that will be called when the button is pressed.
  final void Function(BuildContext context, B bloc) onPressed;

  /// The function that determines the bloc state is a loading state.
  final bool Function(S) isLoading;

  /// The builder that will be used to build the button.
  final Widget Function(
    BuildContext context,
    Widget text,
    void Function()? onPressed,
  ) builder;

  /// The color of the loading indicator.
  final Color? loadingIndicatorColor;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<B>();

    return BlocBuilder<B, S>(
      buildWhen: (previous, current) =>
          isLoading(previous) != isLoading(current),
      builder: (context, state) => builder(
        context,
        Stack(
          children: [
            Opacity(
              opacity: isLoading(state) ? 0 : 1,
              child: text,
            ),
            if (isLoading(state))
              Positioned.fill(
                child: Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) => CCradleLoadingIndicator(
                      color: loadingIndicatorColor,
                      ballSize: constraints.maxHeight * 0.6,
                    ),
                  ),
                ),
              ),
          ],
        ),
        !isLoading(state) ? () => onPressed(context, bloc) : null,
      ),
    );
  }
}
