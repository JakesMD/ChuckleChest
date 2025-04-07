import 'package:auto_route/auto_route.dart';
import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/change_avatar/logic/_logic.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CChangeAvatarPage}
///
/// A widget that allows the user to pick an image from the gallery or camera.
///
/// It also allows the user to crop the image.
///
/// {@endtemplate}
@RoutePage()
class CChangeAvatarPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CChangeAvatarPage}
  CChangeAvatarPage({
    required this.personID,
    required this.avatarURL,
    super.key,
  });

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CAvatarUpdateCubit(personRepository: context.read()),
        ),
        BlocProvider(
          create: (context) =>
              CImagePickCubit(platformRepository: context.read()),
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
              CRequestCubitStatus.succeeded => context.router
                  .maybePop(CAvatarURL(year: avatarURL.year, url: state.url)),
            },
          ),
          BlocListener<CImagePickCubit, CImagePickState>(
            listenWhen: (_, state) =>
                state.status == CRequestCubitStatus.failed,
            listener: (context, _) => const CErrorSnackBar().show(context),
          ),
        ],
        child: this,
      ),
    );
  }

  /// The unique identifier of the person to edit the avatar for.
  final BigInt personID;

  /// The URL of the avatar to edit.
  final CAvatarURL avatarURL;

  final _cropController = CropController();

  void _onCropped(BuildContext context, CropResult result) {
    if (result is CropSuccess) {
      context.read<CAvatarUpdateCubit>().updateAvatarForYear(
            personID: personID,
            image: result.croppedImage,
            year: avatarURL.year,
            chestID: context.read<CCurrentChestCubit>().state.id,
          );
    } else {
      const CErrorSnackBar().show(context);
    }
  }

  void _onGalleryPressed(BuildContext context) => context
      .read<CImagePickCubit>()
      .pickImage(source: CImagePickSource.gallery);

  void _onCameraPressed(BuildContext context) => context
      .read<CImagePickCubit>()
      .pickImage(source: CImagePickSource.camera);

  void _onDonePressed() => _cropController.crop();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CImagePickCubit, CImagePickState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(context.cAppL10n.changeAvatarPage_title(avatarURL.year)),
          bottom: CAppBarLoadingIndicator(
            listeners: [
              CLoadingListener<CAvatarUpdateCubit, CAvatarUpdateState>(),
              CLoadingListener<CImagePickCubit, CImagePickState>(),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: state.succeeded && state.image.isPresent
              ? Crop(
                  controller: _cropController,
                  image: state.image.asNullable!,
                  withCircleUi: true,
                  aspectRatio: 1,
                  onCropped: (result) => _onCropped(context, result),
                )
              : Center(
                  child: Text(
                    context.cAppL10n.changeAvatarPage_message,
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () => _onGalleryPressed(context),
                  icon: const Icon(Icons.photo_library_rounded),
                  label: Text(context.cAppL10n.changeAvatarPage_galleryButton),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: () => _onCameraPressed(context),
                  icon: const Icon(Icons.camera_rounded),
                  label: Text(context.cAppL10n.changeAvatarPage_cameraButton),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: !state.inProgress ? _onDonePressed : null,
          label: Text(context.cAppL10n.changeAvatarPage_doneButton),
          icon: const Icon(Icons.done_rounded),
        ),
      ),
    );
  }
}
