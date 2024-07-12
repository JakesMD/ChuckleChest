import 'package:cauth_repository/cauth_repository.dart';
import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/signin/bloc/_bloc.dart';
import 'package:chuckle_chest/pages/signin/bloc/login/bloc.dart';
import 'package:chuckle_chest/pages/signin/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:cpub/auto_route.dart';
import 'package:cpub/flutter_bloc.dart';
import 'package:flutter/material.dart';

/// {@template CLoginTab}
///
/// The tab that allows the user to log in.
///
/// This tab contains a form for the user to enter their email.
///
/// {@endtemplate}
@RoutePage()
class CLoginTab extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CLoginTab}
  CLoginTab({super.key});

  void _onCompleted(BuildContext context, String email) {
    context.router.push(COTPVerificationRoute(email: email));
  }

  final _formKey = GlobalKey<FormState>();
  final _emailInput = CEmailInput();

  void _onLoginButtonPressed(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<CLoginBloc>().add(
            CLoginFormSubmitted(email: _emailInput.value(context)),
          );
    }
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CLoginBloc(
        authRepository: context.read<CAuthRepository>(),
      ),
      child: BlocListener<CLoginBloc, CLoginState>(
        listener: (context, state) => switch (state) {
          CLoginInitial() => null,
          CLoginInProgress() => null,
          CLoginFailure(exception: final exception) => switch (exception) {
              CLoginException.emailRateLimitExceeded => CErrorSnackBar(
                  message:
                      context.cAppL10n.signinPage_error_emailRateLimitExceeded,
                ).show(context),
              CLoginException.userNotFound => CErrorSnackBar(
                  message: context.cAppL10n.signinPage_error_userNotFound,
                ).show(context),
              CLoginException.unknown => const CErrorSnackBar().show(context),
            },
          CLoginSuccess(email: final email) => _onCompleted(context, email),
        },
        child: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextFormField(
            validator: (v) => _emailInput.validator(input: v, context: context),
            decoration: InputDecoration(
              labelText: context.cAppL10n.signinPage_hint_email,
              icon: const Icon(Icons.email_rounded),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 64),
          CSigninButton.login(onPressed: _onLoginButtonPressed),
        ],
      ),
    );
  }
}
