import 'package:auto_route/auto_route.dart';
import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cchest_repository/cchest_repository.dart';
import 'package:chuckle_chest/pages/manage_chest/logic/_logic.dart';
import 'package:chuckle_chest/pages/manage_chest/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CMembersTab}
///
/// This tab on the manage chest page displays the list of users that have been
/// invited to the chest and allows the user to change thier roles.
///
/// {@endtemplate}
@RoutePage()
class CMembersTab extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CMembersTab}
  const CMembersTab({super.key});

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
    return BlocBuilder<CMembersFetchCubit, CMembersFetchState>(
      builder: (context, membersState) => switch (membersState.status) {
        CRequestCubitStatus.initial =>
          const Center(child: CCradleLoadingIndicator()),
        CRequestCubitStatus.inProgress =>
          const Center(child: CCradleLoadingIndicator()),
        CRequestCubitStatus.failed =>
          const Center(child: Icon(Icons.error_rounded)),
        CRequestCubitStatus.succeeded => ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: membersState.members.length,
            itemBuilder: (context, index) =>
                CMemberCard(member: membersState.members[index]),
          ),
      },
    );
  }
}
