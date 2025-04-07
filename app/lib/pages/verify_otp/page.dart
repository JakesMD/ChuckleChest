import 'package:auto_route/auto_route.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/verify_otp/logic/_logic.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

/// {@template CVerifyOTPPage}
///
/// The page that allows the user to verify their email address and sign in
/// using a one-time password sent to their email.
///
/// {@endtemplate}
@RoutePage()
class CVerifyOTPPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CVerifyOTPPage}
  const CVerifyOTPPage({@QueryParam('email') this.email, super.key});

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

  void _onOTPSubmited(BuildContext context, String pin) {
    if (email == null) return;
    context
        .read<COTPVerificationCubit>()
        .verifyOTP(email: email!.toLowerCase(), pin: pin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.cAppL10n.otpVerificationPage_title),
        centerTitle: true,
        bottom: CAppBarLoadingIndicator(
          listeners: [
            CLoadingListener<COTPVerificationCubit, COTPVerificationState>(),
          ],
        ),
      ),
      body: BlocBuilder<COTPVerificationCubit, COTPVerificationState>(
        builder: (context, state) => CResponsiveListView(
          children: [
            Text(
              context.cAppL10n.otpVerificationPage_message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Pinput(
              length: 6,
              onCompleted: (value) => _onOTPSubmited(context, value),
              separatorBuilder: (_) => const SizedBox(width: 8),
              defaultPinTheme: PinTheme(
                height: 64,
                width: 64,
                textStyle: context.cTextTheme.titleLarge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.fromBorderSide(
                    BorderSide(color: context.cColorScheme.outlineVariant),
                  ),
                ),
              ),
              focusedPinTheme: PinTheme(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.fromBorderSide(
                    BorderSide(color: context.cColorScheme.primary, width: 2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
