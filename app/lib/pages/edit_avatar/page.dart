import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/edit_avatar/logic/_logic.dart';
import 'package:chuckle_chest/pages/edit_avatar/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

/// {@template CEditAvatarPage}
///
/// The page that allows the user to select, crop and upload an avatar for a
/// person.
///
/// When this page is popped, it will return the updated avatar URL.
///
/// {@endtemplate}
@RoutePage()
class CEditAvatarPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CEditAvatarPage}
  CEditAvatarPage({
    required this.personID,
    required this.avatarURL,
    super.key,
  });

  /// The unique identifier of the person to edit the avatar for.
  final BigInt personID;

  /// The URL of the avatar to edit.
  final CAvatarURL avatarURL;

  final _cropController = CropController();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CAvatarUpdateCubit(
            personRepository: context.read(),
          ),
        ),
        BlocProvider(
          create: (context) => CAvatarPickCubit(
            personRepository: context.read(),
          ),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CAvatarUpdateCubit, CAvatarUpdateState>(
            listener: (context, state) => switch (state.status) {
              CRequestCubitStatus.initial => null,
              CRequestCubitStatus.inProgress => null,
              CRequestCubitStatus.failed =>
                const CErrorSnackBar().show(context),
              CRequestCubitStatus.succeeded => context.router.maybePop(
                  CAvatarURL(year: avatarURL.year, url: state.url),
                ),
            },
          ),
          BlocListener<CAvatarPickCubit, CAvatarPickState>(
            listenWhen: (_, state) =>
                state.status == CRequestCubitStatus.failed,
            listener: (context, _) => const CErrorSnackBar().show(context),
          ),
        ],
        child: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        context: context,
        title: Text(context.cAppL10n.editAvatarPage_title(avatarURL.year)),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: avatarURL.url.isNotEmpty
                ? Center(
                    child: Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      clipBehavior: Clip.hardEdge,
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: avatarURL.url,
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
          Positioned.fill(
            child: CEditAvatarPageCrop(
              cropController: _cropController,
              personID: personID,
              avatarURL: avatarURL,
            ),
          ),
        ],
      ),
      bottomNavigationBar: CEditAvatarBottomAppBar(
        personID: personID,
        avatarURL: avatarURL,
        cropController: _cropController,
      ),
    );
  }
}
