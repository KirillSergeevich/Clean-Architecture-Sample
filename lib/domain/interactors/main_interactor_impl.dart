import 'package:todo/domain/client_interfaces/notification_client.dart';
import 'package:todo/domain/data_interfaces/event_repository.dart';
import 'package:todo/domain/data_interfaces/to_do_list_repository.dart';
import 'package:todo/domain/entities/event/event.dart';
import 'package:todo/domain/entities/notification/notification_message.dart';
import 'package:todo/domain/entities/to_do_list/to_do_list.dart';
import 'package:todo/domain/interactor_interfaces/main_interactor.dart';

class MainInteractorImpl implements MainInteractor {
  final EventRepository _eventRepository;
  final ToDoListRepository _toDoListRepository;
  final NotificationClient _notificationClient;

  MainInteractorImpl(
    this._eventRepository,
    this._toDoListRepository,
    this._notificationClient,
  );

  @override
  Future<Event> createEventFromModel(CreateEventModel event) {
    return _eventRepository.createEventFromModel(event);
  }

  @override
  Future<List<Event>> getEvents(int selectedList) => _eventRepository.getEvents(selectedList);

  @override
  Future<void> deleteEvent(int eventId) => _eventRepository.deleteEvent(eventId);

  @override
  Future<void> updateEvent(Event event) => _eventRepository.updateEvent(event);

  @override
  Future<List<ToDoList>> getToDoLists() => _toDoListRepository.getToDoLists();

  @override
  Future<ToDoList> createToDoListFromModel(CreateToDoListModel toDoList) {
    return _toDoListRepository.createToDoListFromModel(toDoList);
  }

  @override
  Future<void> deleteEventsByToDoListId(int toDoListId) {
    return _eventRepository.deleteEventsByToDoListId(toDoListId);
  }

  @override
  Future<void> updateToDoList(ToDoList toDoList) {
    return _toDoListRepository.updateToDoList(toDoList);
  }

  @override
  Future<void> deleteToDoList(int toDoListId) {
    return _toDoListRepository.deleteToDoList(toDoListId);
  }

  @override
  Future<void> addNotification(NotificationMessage message) {
    return _notificationClient.addNotification(message);
  }

  @override
  Future<void> deleteNotification(int notificationId) {
    return _notificationClient.deleteNotification(notificationId);
  }

  @override
  Future<void> updateNotification(NotificationMessage message) {
    return _notificationClient.updateNotification(message);
  }

  @override
  Future<List<String>> pickPictures() {
    return _eventRepository.pickPictures();
  }
}
