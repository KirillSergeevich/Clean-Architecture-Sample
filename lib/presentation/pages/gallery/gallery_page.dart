import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entities/event/event.dart';
import 'package:todo/presentation/app/app.dart';
import 'package:todo/presentation/base/base_page.dart';
import 'package:todo/presentation/pages/gallery/gallery_cubit.dart';
import 'package:todo/presentation/pages/gallery/gallery_state.dart';
import 'package:todo/presentation/widgets/app_icon_button.dart';

class GalleryPage extends BasePage {
  final Event event;

  GalleryPage({required this.event});

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends BasePageState<GalleryPage, GalleryCubit> {
  @override
  void initState() {
    cubit.initPictures(widget.event);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryCubit, GalleryState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(localization.eventGallery),
          ),
          body: Stack(
            children: [
              GridView.builder(
                padding: const EdgeInsets.only(top: 3),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: state.pictures.length,
                itemBuilder: (context, index) {
                  final picture = state.pictures[index];
                  return GestureDetector(
                    onTap: () {
                      cubit.changeIsPicturePreview(true);
                      if (!state.isPicturePreview) {
                        cubit.changeSelectedPictureIndex(index);
                      }
                    },
                    child: Image.file(
                      File(picture),
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
              if (state.pictures.isNotEmpty && state.isPicturePreview) ...[
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5.0,
                    sigmaY: 5.0,
                  ),
                  child: Container(color: theme.blurColor),
                ),
                _PreviewPictureCard(
                  picture: state.pictures[state.selectedPictureIndex],
                  onCancel: () => cubit.changeIsPicturePreview(false),
                  onDelete: () {
                    cubit.deletePicture(widget.event);
                    cubit.changeIsPicturePreview(false);
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _PreviewPictureCard extends StatelessWidget {
  final String picture;
  final VoidCallback onDelete;
  final VoidCallback onCancel;

  const _PreviewPictureCard({
    required this.picture,
    required this.onDelete,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Image.file(
                File(picture),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIconButton(
                      padding: const EdgeInsets.only(right: 10.0),
                      icon: Icons.delete,
                      onClick: onDelete,
                      iconColor: theme.darkIconColor,
                    ),
                    AppIconButton(
                      iconColor: theme.darkIconColor,
                      icon: Icons.cancel_outlined,
                      onClick: onCancel,
                    ),
                    const SizedBox(height: 40.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
