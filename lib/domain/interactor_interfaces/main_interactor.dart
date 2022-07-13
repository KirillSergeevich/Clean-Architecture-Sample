import 'package:todo/domain/entities/event/event.dart';
import 'package:todo/domain/entities/notification/notification_message.dart';
import 'package:todo/domain/entities/to_do_list/to_do_list.dart';

abstract class MainInteractor {
  Future<Event> createEventFromModel(CreateEventModel event);

  Future<void> addNotification(NotificationMessage message);

  Future<void> deleteNotification(int notificationId);

  Future<void> updateNotification(NotificationMessage message);

  Future<List<Event>> getEvents(int selectedList);

  Future<void> deleteEvent(int eventId);

  Future<void> deleteEventsByToDoListId(int toDoListId);

  Future<void> updateEvent(Event event);

  Future<List<ToDoList>> getToDoLists();

  Future<void> deleteToDoList(int toDoListId);

  Future<void> updateToDoList(ToDoList toDoList);

  Future<ToDoList> createToDoListFromModel(CreateToDoListModel toDoList);

  Future<List<String>> pickPictures();
}
