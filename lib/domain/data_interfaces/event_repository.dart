import 'package:todo/domain/entities/event/event.dart';

abstract class EventRepository {
  Future<void> updateEvent(Event event);

  Future<Event> createEventFromModel(CreateEventModel event);

  Future<List<Event>> getEvents(int selectedList);

  Future<void> deleteEventsByToDoListId(int toDoListId);

  Future<void> deleteEvent(int eventId);

  Future<List<String>> pickPictures();
}
