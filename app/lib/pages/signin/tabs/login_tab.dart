import 'package:auto_route/auto_route.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/signin/logic/login_cubit.dart';
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

  final _formKey = GlobalKey<FormFieldState<String>>();
  final _emailInput = CEmailInput();

  void _onSubmitted(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<CLoginCubit>().logIn(email: _emailInput.value!);
    }
  }

  void _onLoginSuccessful(BuildContext context, String email) =>
      context.pushRoute(COTPVerificationRoute(email: email));

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocListener<CLoginCubit, CLoginState>(
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
        CRequestCubitStatus.succeeded =>
          _onLoginSuccessful(context, state.email),
      },
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CResponsiveListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      children: [
        TextFormField(
          key: _formKey,
          validator: (value) => _emailInput.formFieldValidator(value, context),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: context.cAppL10n.signinPage_hint_email,
            prefixIcon: const Icon(Icons.email_rounded),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 64),
        BlocBuilder<CLoginCubit, CLoginState>(
          builder: (context, state) => FilledButton(
            onPressed: !state.inProgress ? () => _onSubmitted(context) : null,
            child: Text(context.cAppL10n.signinPage_loginButton),
          ),
        ),
      ],
    );
  }
}
