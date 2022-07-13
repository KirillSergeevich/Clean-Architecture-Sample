import 'package:todo/domain/entities/event/event.dart';
import 'package:todo/domain/entities/notification/notification_message.dart';
import 'package:todo/domain/entities/to_do_list/to_do_list.dart';
import 'package:todo/domain/interactor_interfaces/main_interactor.dart';
import 'package:todo/presentation/app/app.dart';
import 'package:todo/presentation/base/base_cubit.dart';
import 'package:todo/presentation/pages/main/constants/constants.dart';
import 'package:todo/presentation/pages/main/main_state.dart';

class MainCubit extends BaseCubit<MainState> {
  final MainInteractor _mainInteractor;

  MainCubit(this._mainInteractor) : super(MainState.initState());

  void changeSelectedList(int selectedListId) {
    final displayedEvents = _findDisplayedEvents(
      selectedListId: selectedListId,
      events: state.events,
    );
    emit(state.newState(selectedListId: selectedListId, displayedEvents: displayedEvents));
  }

  void filterEventsBySearchText(String searchText) {
    final searchPattern = searchText.toUpperCase();
    final displayedEvents = state.selectedListId == allListsItemId
        ? state.events.where((event) => event.title.toUpperCase().contains(searchPattern)).toList()
        : state.events
            .where((event) => event.toDoListId == state.selectedListId)
            .where((event) => event.title.toUpperCase().contains(searchPattern))
            .toList();
    emit(state.newState(displayedEvents: displayedEvents));
  }

  void changeIsToDoListCreated(bool isToDoListCreated) {
    emit(state.newState(isToDoListCreated: isToDoListCreated));
  }

  List<Event> _findDisplayedEvents({
    required int selectedListId,
    required List<Event> events,
  }) {
    List<Event> displayedEvents;
    if (selectedListId == allListsItemId) {
      displayedEvents = [...events];
    } else {
      displayedEvents = events.where((event) => event.toDoListId == selectedListId).toList();
    }
    return displayedEvents;
  }

  @override
  void init() async {
    final events = await _mainInteractor.getEvents(state.selectedListId);
    final displayedEvents = _findDisplayedEvents(
      selectedListId: state.selectedListId,
      events: events.reversed.toList(),
    );
    final toDoLists = await _mainInteractor.getToDoLists();
    final displayedToDoLists = [
      ToDoList(id: allListsItemId, title: localization.allEvents),
      ...toDoLists.reversed.toList(),
    ];
    emit(
      state.newState(
        events: events.reversed.toList(),
        displayedEvents: displayedEvents,
        toDoLists: displayedToDoLists,
      ),
    );
  }

  void updateEvent({
    required Event currentEvent,
    int? selectedListId,
    String? title,
    String? description,
    String? reminderDate,
    bool? isEventCompleted,
    List<String>? pictures,
  }) async {
    final isToDoListChanged = selectedListId != state.selectedListId;
    final updatedEvent = currentEvent.copyWith(
      title: title,
      toDoListId: selectedListId,
      description: description,
      reminderDate: reminderDate,
      isEventCompleted: isEventCompleted,
      pictures: [if (pictures != null) ...pictures, ...currentEvent.pictures],
    );
    if (reminderDate != null && reminderDate.isNotEmpty) {
      await _mainInteractor.updateNotification(
        NotificationMessage(
          id: updatedEvent.id,
          title: updatedEvent.title,
          description: updatedEvent.description,
          reminderDate: reminderDate,
        ),
      );
    }
    isToDoListChanged
        ? _updateEventWhenToDoListChanged(updatedEvent)
        : _simpleEventUpdate(updatedEvent);
  }

  void _updateEventWhenToDoListChanged(Event event) async {
    await _mainInteractor.deleteEvent(event.id);
    final createdEvent = await _mainInteractor.createEventFromModel(
      CreateEventModel(
        toDoListId: event.toDoListId,
        title: event.title,
        description: event.description,
        reminderDate: event.reminderDate,
        isEventCompleted: event.isEventCompleted,
        pictures: event.pictures,
      ),
    );
    final events = state.events
      ..removeWhere((event) => event.id == event.id)
      ..insert(0, createdEvent);
    final displayedEvents = _findDisplayedEvents(
      selectedListId: state.selectedListId,
      events: events,
    );
    emit(state.newState(events: events, displayedEvents: displayedEvents));
  }

  void _simpleEventUpdate(Event event) async {
    await _mainInteractor.updateEvent(event);
    final eventsIndex = state.events.indexWhere((event) => event.id == event.id);
    final events = state.events
      ..removeWhere((event) => event.id == event.id)
      ..insert(eventsIndex, event);
    final displayedEvents = _findDisplayedEvents(
      selectedListId: state.selectedListId,
      events: events,
    );
    emit(state.newState(events: events, displayedEvents: displayedEvents));
  }

  void updateToDoList({required String title, required ToDoList currentToDoList}) async {
    final updatedToDoList = currentToDoList.copyWith(title: title);
    await _mainInteractor.updateToDoList(updatedToDoList);
    final toDoListIndex =
        state.toDoLists.indexWhere((toDoList) => toDoList.id == updatedToDoList.id);
    final toDoLists = state.toDoLists
      ..removeWhere((toDoList) => toDoList.id == updatedToDoList.id)
      ..insert(toDoListIndex, updatedToDoList);
    emit(state.newState(toDoLists: toDoLists));
  }

  void deleteToDoList(int toDoListId) async {
    await _mainInteractor.deleteToDoList(toDoListId);
    await _mainInteractor.deleteEventsByToDoListId(toDoListId);
    final events = state.events..removeWhere((event) => event.toDoListId == toDoListId);
    final displayedEvents = state.displayedEvents
      ..removeWhere((event) => event.toDoListId == toDoListId);
    final toDoLists = state.toDoLists..removeWhere((todoList) => todoList.id == toDoListId);
    emit(state.newState(toDoLists: toDoLists, events: events, displayedEvents: displayedEvents));
  }

  void deleteEvent(int eventId) async {
    await _mainInteractor.deleteEvent(eventId);
    final event = state.events.firstWhere((event) => event.id == eventId);
    if (event.reminderDate.isNotEmpty) {
      await _mainInteractor.deleteNotification(event.id);
    }
    final events = state.events..removeWhere((event) => event.id == eventId);
    final displayedEvents = state.displayedEvents..removeWhere((event) => event.id == eventId);
    emit(state.newState(events: events, displayedEvents: displayedEvents));
  }

  void createToDoList(String title) async {
    final createdToDoList = await _mainInteractor.createToDoListFromModel(
      CreateToDoListModel(title: title),
    );
    final toDoLists = state.toDoLists..insert(toDoListsFirstIndex, createdToDoList);
    emit(state.newState(toDoLists: toDoLists, isToDoListCreated: true));
  }

  void restoreDisplayedEvents() {
    final displayedEvents = _findDisplayedEvents(
      events: state.events,
      selectedListId: state.selectedListId,
    );
    emit(state.newState(displayedEvents: displayedEvents));
  }

  void changeIsSearchPressed(bool isSearchPressed) {
    emit(state.newState(isSearchPressed: isSearchPressed));
  }

  void createEvent({
    required String title,
    required String description,
    required String reminderDate,
    required int selectedListId,
    required List<String> pictures,
  }) async {
    final event = CreateEventModel(
      title: title,
      description: description,
      toDoListId: selectedListId,
      reminderDate: reminderDate,
      isEventCompleted: false,
      pictures: pictures,
    );
    final createdEvent = await _mainInteractor.createEventFromModel(event);
    if (reminderDate.isNotEmpty) {
      _mainInteractor.addNotification(
        NotificationMessage(
          id: createdEvent.id,
          title: createdEvent.title,
          description: createdEvent.description,
          reminderDate: reminderDate,
        ),
      );
    }
    final events = state.events..insert(0, createdEvent);
    final displayedEvents = _findDisplayedEvents(
      selectedListId: state.selectedListId,
      events: events,
    );
    emit(state.newState(events: events, displayedEvents: displayedEvents));
  }
}
