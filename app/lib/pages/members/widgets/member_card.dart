import 'package:cchest_repository/cchest_repository.dart';
import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/pages/members/logic/member_role_update_cubit.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signed_spacing_flex/signed_spacing_flex.dart';

/// {@template CMemberCard}
///
/// The card on the members tab of the manage chest page that displays a member
/// and allows the user to change their role.
///
/// {@endtemplate}
class CMemberCard extends StatelessWidget {
  /// {@macro CMemberCard}
  const CMemberCard({
    required this.member,
    super.key,
  });

  /// The member that this card represents.
  final CMember member;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<CMemberRoleUpdateCubit, CMemberRoleUpdateState>(
          builder: (context, state) => SignedSpacingColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 24,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      member.username ?? '',
                      style: context.cTextTheme.titleMedium,
                    ),
                  ),
                  if (state.status == CRequestCubitStatus.inProgress)
                    const CBouncyBallLoadingIndicator(),
                ],
              ),
              SegmentedButton(
                segments: [
                  ButtonSegment(
                    value: CUserRole.viewer,
                    label: Text(
                      CUserRole.viewer.cLocalize(context),
                    ),
                  ),
                  ButtonSegment(
                    value: CUserRole.collaborator,
                    label: Text(
                      CUserRole.collaborator.cLocalize(context),
                    ),
                  ),
                ],
                selected: {member.role},
                onSelectionChanged: state.status !=
                        CRequestCubitStatus.inProgress
                    ? (Set<CUserRole> selected) => context
                        .read<CMemberRoleUpdateCubit>()
                        .updateMemberRole(member: member, role: selected.first)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
