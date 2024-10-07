import 'package:auto_route/auto_route.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/signin/bloc/_bloc.dart';
import 'package:chuckle_chest/pages/signin/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()

/// {@template CSignupTab}
///
/// The tab that allows the user to sign up.
///
/// This tab contains a form for the user to enter their username and email.
///
/// {@endtemplate}
class CSignupTab extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CSignupTab}
  CSignupTab({super.key});

  void _onCompleted(BuildContext context, String email) {
    context.router.push(COTPVerificationRoute(email: email));
  }

  final _formKey = GlobalKey<FormState>();
  final _usernameInput = CTextInput();
  final _emailInput = CEmailInput();

  void _onSignupButtonPressed(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<CSignupBloc>().add(
            CSignupFormSubmitted(
              username: _usernameInput.value(context),
              email: _emailInput.value(context),
            ),
          );
    }
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CSignupBloc(
        authRepository: context.read<CAuthRepository>(),
      ),
      child: BlocListener<CSignupBloc, CSignupState>(
        listener: (context, state) => switch (state) {
          CSignupInitial() => null,
          CSignupInProgress() => null,
          CSignupFailure(exception: final exception) => switch (exception) {
              CSignupException.emailRateLimitExceeded => CErrorSnackBar(
                  message:
                      context.cAppL10n.signinPage_error_emailRateLimitExceeded,
                ).show(context),
              CSignupException.unknown => const CErrorSnackBar().show(context),
            },
          CSignupSuccess(email: final email) => _onCompleted(context, email),
        },
        child: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialBanner(
          content: Text(context.cAppL10n.signinPage_disabledBanner),
          actions: [
            TextButton(
              onPressed: () => context.router.replaceAll([CLoginRoute()]),
              child: Text(context.cAppL10n.signinPage_loginButton),
            ),
          ],
        ),
        Expanded(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                TextFormField(
                  enabled: false,
                  validator: (v) => _usernameInput.validator(
                    input: v,
                    context: context,
                  ),
                  decoration: InputDecoration(
                    labelText: context.cAppL10n.signinPage_hint_username,
                    icon: const Icon(Icons.person_rounded),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  enabled: false,
                  validator: (v) => _emailInput.validator(
                    input: v,
                    context: context,
                  ),
                  decoration: InputDecoration(
                    labelText: context.cAppL10n.signinPage_hint_email,
                    icon: const Icon(Icons.email_rounded),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 64),
                CSigninButton.signup(
                  isEnabled: false,
                  onPressed: _onSignupButtonPressed,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
