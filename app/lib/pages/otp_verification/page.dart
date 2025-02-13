import 'package:auto_route/auto_route.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/otp_verification/logic/_logic.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

/// {@template COTPVerificationPage}
///
/// The page that allows the user to verify their email address and sign in
/// using a one-time password sent to their email.
///
/// {@endtemplate}
@RoutePage()
class COTPVerificationPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro COTPVerificationPage}
  const COTPVerificationPage({@QueryParam('email') this.email, super.key});

  /// The email address to verify.
  final String? email;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          COTPVerificationCubit(authRepository: context.read()),
      child: BlocListener<COTPVerificationCubit, COTPVerificationState>(
        listener: (context, state) => switch (state.failure) {
          COTPVerificationException.invalidToken => CErrorSnackBar(
              message: context.cAppL10n.otpVerificationPage_error_invalidToken,
            ).show(context),
          COTPVerificationException.unknown =>
            const CErrorSnackBar().show(context),
        },
        listenWhen: (_, state) => state.failed,
        child: this,
      ),
    );
  }

  Future<void> _onBackButtonPressed(BuildContext context) async {
    if (!(await context.router.maybePop()) && context.mounted) {
      await context.router.replaceAll([const CSigninRoute()]);
    }
  }

  void _onOTPSubmited(BuildContext context, String pin) {
    if (email == null) return;
    context
        .read<COTPVerificationCubit>()
        .verifyOTP(email: email!.toLowerCase(), pin: pin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        context: context,
        title: BlocBuilder<COTPVerificationCubit, COTPVerificationState>(
          builder: (context, state) =>
              state.status == CRequestCubitStatus.inProgress
                  ? const CCradleLoadingIndicator()
                  : Text(context.cAppL10n.otpVerificationPage_title),
        ),
        leading: BackButton(onPressed: () => _onBackButtonPressed(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(context.cAppL10n.otpVerificationPage_message),
              const SizedBox(height: 16),
              Pinput(
                length: 6,
                onCompleted: (pin) => _onOTPSubmited(context, pin),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
