import 'package:todo/domain/data_interfaces/event_repository.dart';
import 'package:todo/domain/entities/event/event.dart';
import 'package:todo/domain/interactor_interfaces/gallery_interactor.dart';

class GalleryInteractorImpl implements GalleryInteractor {
  final EventRepository _eventRepository;

  GalleryInteractorImpl(this._eventRepository);

  @override
  Future<void> updateEvent(Event event) {
    return _eventRepository.updateEvent(event);
  }
}
