import 'package:auto_route/auto_route.dart';
import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cchest_repository/cchest_repository.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/members/logic/_logic.dart';
import 'package:chuckle_chest/pages/members/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CMembersPage}
///
/// The page that displays the list of members and allows the user to change
/// their roles.
///
/// {@endtemplate}
@RoutePage()
class CMembersPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CMembersPage}
  const CMembersPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CMembersFetchCubit(
            chestRepository: context.read(),
            chestID: context.read<CCurrentChestCubit>().state.id,
          )..fetchMembers(),
        ),
        BlocProvider(
          create: (_) => CMemberRoleUpdateCubit(
            chestRepository: context.read(),
          ),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CMembersFetchCubit, CMembersFetchState>(
            listener: (context, membersState) =>
                const CErrorSnackBar().show(context),
            listenWhen: (_, membersState) =>
                membersState.status == CRequestCubitStatus.failed,
          ),
          BlocListener<CMemberRoleUpdateCubit, CMemberRoleUpdateState>(
            listener: (context, state) => switch (state.status) {
              CRequestCubitStatus.initial => null,
              CRequestCubitStatus.inProgress => null,
              CRequestCubitStatus.failed =>
                const CErrorSnackBar().show(context),
              CRequestCubitStatus.succeeded =>
                context.read<CMembersFetchCubit>().updateMember(
                      member: (state.member as BobsPresent<CMember>).value,
                    ),
            },
          ),
        ],
        child: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.cAppL10n.membersPage_title)),
      body: BlocBuilder<CMembersFetchCubit, CMembersFetchState>(
        builder: (context, membersState) => switch (membersState.status) {
          CRequestCubitStatus.initial =>
            const Center(child: CCradleLoadingIndicator()),
          CRequestCubitStatus.inProgress =>
            const Center(child: CCradleLoadingIndicator()),
          CRequestCubitStatus.failed =>
            const Center(child: Icon(Icons.error_rounded)),
          CRequestCubitStatus.succeeded => CResponsiveListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              items: membersState.members,
              itemBuilder: (context, member) => CMemberCard(member: member),
            ),
        },
      ),
    );
  }
}
