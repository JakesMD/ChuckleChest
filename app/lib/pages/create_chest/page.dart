import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/_app.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CCreateChestPage}
///
/// Widget that displays the page to create a new chest.
///
/// {@endtemplate}
@RoutePage()
class CCreateChestPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CCreateChestPage}
  CCreateChestPage({super.key});

  final _formKey = GlobalKey<FormFieldState<String>>();
  final _nameInput = CTextInput();

  void _onSubmitted(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context
          .read<CChestCreationCubit>()
          .createChest(chestName: _nameInput.value!);
    }
  }

  void _onChestCreated(BuildContext context, String chestID) {
    context.router.replaceAll(
      [const CBaseRoute(), CChestRoute(chestID: chestID)],
      updateExistingRoutes: false,
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CChestCreationCubit(chestRepository: context.read()),
      child: BlocListener<CChestCreationCubit, CChestCreationState>(
        listener: (context, state) => switch (state.status) {
          CRequestCubitStatus.initial => null,
          CRequestCubitStatus.inProgress => null,
          CRequestCubitStatus.failed => const CErrorSnackBar().show(context),
          CRequestCubitStatus.succeeded =>
            _onChestCreated(context, state.chestID),
        },
        child: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.cAppL10n.createChestPage_title),
        centerTitle: true,
        bottom: CAppBarLoadingIndicator(
          listeners: [
            CLoadingListener<CChestCreationCubit, CChestCreationState>(),
          ],
        ),
      ),
      body: CResponsiveListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            key: _formKey,
            validator: (value) => _nameInput.formFieldValidator(value, context),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: context.cAppL10n.createChestPage_hint_chestName,
              prefixIcon: const Icon(Icons.inventory_2_rounded),
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
      floatingActionButton:
          BlocBuilder<CChestCreationCubit, CChestCreationState>(
        builder: (context, state) => FloatingActionButton.extended(
          onPressed: !state.inProgress ? () => _onSubmitted(context) : null,
          icon: const Icon(Icons.add_rounded),
          label: Text(context.cAppL10n.createChestPage_createButton),
        ),
      ),
    );
  }
}
