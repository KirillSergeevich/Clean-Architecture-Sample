import 'package:todo/domain/entities/event/event.dart';

abstract class GalleryInteractor {
  Future<void> updateEvent(Event event);
}
