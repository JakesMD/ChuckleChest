import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/signin/logic/_logic.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';

enum _CSigninButtonType { login, signup }

/// {@template CSigninButton}
///
/// A button on the signin page for logging in or signing up.
///
/// {@endtemplate}
class CSigninButton extends StatelessWidget {
  /// {@macro CSigninButton}
  ///
  /// This button is used for logging in.
  const CSigninButton.login({
    required this.onPressed,
    this.isEnabled = true,
    super.key,
  }) : _type = _CSigninButtonType.login;

  /// {@macro CSigninButton}
  ///
  /// This button is used for signing up.
  const CSigninButton.signup({
    required this.onPressed,
    this.isEnabled = true,
    super.key,
  }) : _type = _CSigninButtonType.signup;

  /// The function to call when the button is pressed.
  final void Function(BuildContext) onPressed;

  /// Whether the button is enabled.
  final bool isEnabled;

  final _CSigninButtonType _type;

  @override
  Widget build(BuildContext context) {
    if (_type == _CSigninButtonType.login) {
      return CLoadingButton<CLoginCubit, CLoginState>(
        isLoading: (state) => state.status == CRequestCubitStatus.inProgress,
        isEnabled: isEnabled,
        onPressed: (context, bloc) => onPressed(context),
        builder: (context, text, onPressed) => FilledButton(
          onPressed: onPressed,
          child: text,
        ),
        child: Text(
          _type == _CSigninButtonType.login
              ? context.cAppL10n.signinPage_loginButton
              : context.cAppL10n.signinPage_signupButton,
        ),
      );
    }
    return CLoadingButton<CSignupCubit, CSignupState>(
      isLoading: (state) => state.status == CRequestCubitStatus.inProgress,
      isEnabled: isEnabled,
      onPressed: (context, bloc) => onPressed(context),
      builder: (context, text, onPressed) => FilledButton(
        onPressed: onPressed,
        child: text,
      ),
      child: Text(
        _type == _CSigninButtonType.login
            ? context.cAppL10n.signinPage_loginButton
            : context.cAppL10n.signinPage_signupButton,
      ),
    );
  }
}
