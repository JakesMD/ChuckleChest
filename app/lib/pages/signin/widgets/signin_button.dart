import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/signin/bloc/_bloc.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:cpub/flutter_bloc.dart';
import 'package:flutter/material.dart';

enum _CSigninButtonType { login, signup }

/// {@template CSigninButton}
///
/// A button for logging in or signing up.
///
/// {@endtemplate}
class CSigninButton extends StatelessWidget {
  /// {@macro CSigninButton}
  ///
  /// This button is used for logging in.
  const CSigninButton.login({required this.onPressed, super.key})
      : _type = _CSigninButtonType.login;

  /// {@macro CSigninButton}
  ///
  /// This button is used for signing up.
  const CSigninButton.signup({required this.onPressed, super.key})
      : _type = _CSigninButtonType.signup;

  /// The function to call when the button is pressed.
  final void Function(BuildContext) onPressed;

  final _CSigninButtonType _type;

  @override
  Widget build(BuildContext context) {
    if (_type == _CSigninButtonType.login) {
      return BlocBuilder<CLoginBloc, CLoginState>(
        builder: (context, state) => _buildButton(
          context,
          state is CLoginInProgress,
        ),
      );
    }
    return BlocBuilder<CSignupBloc, CSignupState>(
      builder: (context, state) => _buildButton(
        context,
        state is CSignupInProgress,
      ),
    );
  }

  Widget _buildButton(BuildContext context, bool isLoading) {
    return FilledButton(
      onPressed: !isLoading ? () => onPressed(context) : null,
      child: SizedBox(
        height: 44,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: isLoading
                ? CCradleLoadingIndicator(
                    color: Theme.of(context).colorScheme.onPrimary,
                  )
                : Text(
                    _type == _CSigninButtonType.login
                        ? context.cAppL10n.signinPage_loginButton
                        : context.cAppL10n.signinPage_signupButton,
                  ),
          ),
        ),
      ),
    );
  }
}
