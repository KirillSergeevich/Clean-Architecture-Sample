import 'package:todo/domain/entities/event/event.dart';
import 'package:todo/domain/interactor_interfaces/gallery_interactor.dart';
import 'package:todo/presentation/base/base_cubit.dart';
import 'package:todo/presentation/pages/gallery/gallery_state.dart';

class GalleryCubit extends BaseCubit<GalleryState> {
  final GalleryInteractor _galleryInteractor;

  GalleryCubit(this._galleryInteractor) : super(GalleryState.initState());

  void initPictures(Event event) async {
    emit(state.newState(pictures: event.pictures));
  }

  void deletePicture(Event event) async {
    final pictures = state.pictures..removeAt(state.selectedPictureIndex);
    final updatedEvent = event.copyWith(pictures: pictures);
    await _galleryInteractor.updateEvent(updatedEvent);
    emit(state.newState(pictures: pictures));
  }

  void changeIsPicturePreview(bool isPicturePreview) {
    emit(state.newState(isPicturePreview: isPicturePreview));
  }

  void changeSelectedPictureIndex(int selectedPictureIndex) {
    emit(state.newState(selectedPictureIndex: selectedPictureIndex));
  }
}
