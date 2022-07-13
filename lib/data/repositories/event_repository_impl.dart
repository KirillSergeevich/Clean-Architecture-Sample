import 'package:todo/data/data_sources/interfaces/database_data_source.dart';
import 'package:todo/domain/client_interfaces/picture_picker_client.dart';
import 'package:todo/domain/data_interfaces/event_repository.dart';
import 'package:todo/domain/entities/event/event.dart';

class EventRepositoryImpl implements EventRepository {
  final DatabaseDataSource _databaseDataSource;
  final PicturePickerClient _picturePickerClient;

  EventRepositoryImpl(this._databaseDataSource, this._picturePickerClient);

  @override
  Future<Event> createEventFromModel(CreateEventModel event) {
    return _databaseDataSource.createEventFromModel(event);
  }

  @override
  Future<void> deleteEvent(int eventId) {
    return _databaseDataSource.deleteEvent(eventId);
  }

  @override
  Future<List<Event>> getEvents(int selectedList) {
    return _databaseDataSource.getEvents(selectedList);
  }

  @override
  Future<void> updateEvent(Event event) {
    return _databaseDataSource.updateEvent(event);
  }

  @override
  Future<void> deleteEventsByToDoListId(int toDoListId) {
    return _databaseDataSource.deleteEventsByToDoListId(toDoListId);
  }

  @override
  Future<List<String>> pickPictures() {
    return _picturePickerClient.pickPictures();
  }
}
