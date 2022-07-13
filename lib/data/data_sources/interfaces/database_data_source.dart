import 'package:todo/domain/entities/event/event.dart';
import 'package:todo/domain/entities/to_do_list/to_do_list.dart';

abstract class DatabaseDataSource {
  Future<void> updateEvent(Event event);

  Future<Event> createEventFromModel(CreateEventModel event);

  Future<List<Event>> getEvents(int selectedList);

  Future<void> deleteEvent(int eventId);

  Future<void> deleteEventsByToDoListId(int toDoListId);

  Future<List<ToDoList>> getToDoLists();

  Future<ToDoList> createToDoListFromModel(CreateToDoListModel toDoList);

  Future<void> deleteToDoList(int toDoListId);

  Future<void> updateToDoList(ToDoList toDoList);

  void dispose();
}
