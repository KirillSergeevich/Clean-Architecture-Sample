import 'package:todo/presentation/base/base_state.dart';

class GalleryState extends BaseState {
  final List<String> pictures;
  final int selectedPictureIndex;
  final bool isPicturePreview;

  GalleryState({
    required this.pictures,
    required this.selectedPictureIndex,
    required this.isPicturePreview,
  });

  GalleryState.initState()
      : pictures = const [],
        selectedPictureIndex = 0,
        isPicturePreview = false;

  GalleryState newState({
    List<String>? pictures,
    int? selectedPictureIndex,
    bool? isPicturePreview,
  }) {
    return GalleryState(
      pictures: pictures ?? this.pictures,
      selectedPictureIndex: selectedPictureIndex ?? this.selectedPictureIndex,
      isPicturePreview: isPicturePreview ?? this.isPicturePreview,
    );
  }
}
