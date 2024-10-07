import 'package:auto_route/auto_route.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/signin/logic/login_cubit.dart';
import 'package:chuckle_chest/pages/signin/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CLoginTab}
///
/// The tab on the signin page that allows the user to log in.
///
/// This tab contains a form for the user to enter their email.
///
/// {@endtemplate}
@RoutePage()
class CLoginTab extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CLoginTab}
  CLoginTab({super.key});

  void _onCompleted(BuildContext context, String email) =>
      context.router.push(COTPVerificationRoute(email: email));

  final _formKey = GlobalKey<FormState>();
  final _emailInput = CEmailInput();

  void _onLoginButtonPressed(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<CLoginCubit>().logIn(email: _emailInput.value(context));
    }
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CLoginCubit(authRepository: context.read()),
      child: BlocListener<CLoginCubit, CLoginState>(
        listener: (context, state) => switch (state.status) {
          CRequestCubitStatus.initial => null,
          CRequestCubitStatus.inProgress => null,
          CRequestCubitStatus.failed => switch (state.failure) {
              CLoginException.emailRateLimitExceeded => CErrorSnackBar(
                  message:
                      context.cAppL10n.signinPage_error_emailRateLimitExceeded,
                ).show(context),
              CLoginException.userNotFound => CErrorSnackBar(
                  message: context.cAppL10n.signinPage_error_userNotFound,
                ).show(context),
              CLoginException.unknown => const CErrorSnackBar().show(context),
            },
          CRequestCubitStatus.succeeded => _onCompleted(context, state.email),
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
