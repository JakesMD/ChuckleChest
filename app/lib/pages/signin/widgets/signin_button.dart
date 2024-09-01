import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/signin/bloc/_bloc.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
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
      return CLoadingButton<CLoginBloc, CLoginState>(
        isLoading: (state) => state is CLoginInProgress,
        text: Text(
          _type == _CSigninButtonType.login
              ? context.cAppL10n.signinPage_loginButton
              : context.cAppL10n.signinPage_signupButton,
        ),
        onPressed: (context, bloc) => onPressed(context),
        builder: (context, text, onPressed) => FilledButton(
          onPressed: onPressed,
          child: text,
        ),
      );
    }
    return CLoadingButton<CSignupBloc, CSignupState>(
      isLoading: (state) => state is CSignupInProgress,
      text: Text(
        _type == _CSigninButtonType.login
            ? context.cAppL10n.signinPage_loginButton
            : context.cAppL10n.signinPage_signupButton,
      ),
      onPressed: (context, bloc) => onPressed(context),
      builder: (context, text, onPressed) => FilledButton(
        onPressed: onPressed,
        child: text,
      ),
    );
  }
}
