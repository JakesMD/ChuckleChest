// Used for seemless use with material widgets.
// ignore_for_file: avoid_positional_boolean_parameters

import 'package:auto_route/auto_route.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/signin/logic/_logic.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

/// {@template CSignupTab}
///
/// The tab on the signin page that allows the user to sign up.
///
/// This tab contains a form for the user to enter their username and email.
///
/// {@endtemplate}
@RoutePage()
class CSignupTab extends StatefulWidget implements AutoRouteWrapper {
  /// {@macro CSignupTab}
  const CSignupTab({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CSignupCubit(authRepository: context.read()),
      child: BlocListener<CSignupCubit, CSignupState>(
        listener: (context, state) => switch (state.status) {
          CRequestCubitStatus.initial => null,
          CRequestCubitStatus.inProgress => null,
          CRequestCubitStatus.failed => switch (state.failure) {
              CSignupException.emailRateLimitExceeded => CErrorSnackBar(
                  message:
                      context.cAppL10n.signinPage_error_emailRateLimitExceeded,
                ).show(context),
              CSignupException.unknown => const CErrorSnackBar().show(context),
            },
          CRequestCubitStatus.succeeded =>
            _onSignupSuccessful(context, state.email),
        },
        child: this,
      ),
    );
  }

  void _onSignupSuccessful(BuildContext context, String email) =>
      context.router.push(COTPVerificationRoute(email: email));

  @override
  State<CSignupTab> createState() => _CSignupTabState();
}

class _CSignupTabState extends State<CSignupTab> {
  final formKey = GlobalKey<FormState>();

  final usernameInput = CTextInput();

  final emailInput = CEmailInput();

  bool isAgeConfirmed = false;

  bool isPrivacyAccepted = false;

  bool isTermsAccepted = false;

  void onAgeToggled(bool? value) =>
      setState(() => isAgeConfirmed = value ?? isAgeConfirmed);

  void onPrivacyToggled(bool? value) =>
      setState(() => isPrivacyAccepted = value ?? isPrivacyAccepted);

  void onTermsToggled(bool? value) =>
      setState(() => isTermsAccepted = value ?? isTermsAccepted);

  void onPrivacyLinkPressed() =>
      launchUrl(Uri.parse('https://chucklechest.app/privacy'));

  void onTermsLinkPressed() =>
      launchUrl(Uri.parse('https://chucklechest.app/terms'));

  void onSubmitted(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      context.read<CSignupCubit>().signUp(
            username: usernameInput.value!,
            email: emailInput.value!,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: CResponsiveListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        children: [
          TextFormField(
            validator: (value) =>
                usernameInput.formFieldValidator(value, context),
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: context.cAppL10n.signinPage_hint_username,
              prefixIcon: const Icon(Icons.person_rounded),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 32),
          TextFormField(
            validator: (value) => emailInput.formFieldValidator(value, context),
            decoration: InputDecoration(
              labelText: context.cAppL10n.signinPage_hint_email,
              prefixIcon: const Icon(Icons.email_rounded),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 48),
          ListTile(
            leading: Checkbox(value: isAgeConfirmed, onChanged: onAgeToggled),
            titleTextStyle: context.cTextTheme.bodyMedium,
            title: Text(
              context.cAppL10n.signinPage_ageConfirmation,
              style: TextStyle(color: context.cColorScheme.onSurface),
            ),
          ),
          ListTile(
            leading:
                Checkbox(value: isPrivacyAccepted, onChanged: onPrivacyToggled),
            title: RichText(
              text: TextSpan(
                text: context.cAppL10n.signinPage_agreement,
                style: TextStyle(
                  color: context.cColorScheme.onSurface,
                  fontFamily: 'ReadexPro',
                ),
                children: [
                  TextSpan(
                    text: context.cAppL10n.signinPage_privacyPolicy,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = onPrivacyLinkPressed,
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading:
                Checkbox(value: isTermsAccepted, onChanged: onTermsToggled),
            title: RichText(
              text: TextSpan(
                text: context.cAppL10n.signinPage_agreement,
                style: TextStyle(
                  color: context.cColorScheme.onSurface,
                  fontFamily: 'ReadexPro',
                ),
                children: [
                  TextSpan(
                    text: context.cAppL10n.signinPage_terms,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = onTermsLinkPressed,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 64),
          BlocBuilder<CSignupCubit, CSignupState>(
            builder: (context, state) => FilledButton(
              onPressed: !state.inProgress &&
                      isPrivacyAccepted &&
                      isTermsAccepted &&
                      isAgeConfirmed
                  ? () => onSubmitted(context)
                  : null,
              child: Text(context.cAppL10n.signinPage_signupButton),
            ),
          ),
        ],
      ),
    );
  }
}
