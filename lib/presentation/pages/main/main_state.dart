import 'package:todo/domain/entities/event/event.dart';
import 'package:todo/domain/entities/to_do_list/to_do_list.dart';
import 'package:todo/presentation/base/base_state.dart';
import 'package:todo/presentation/pages/main/constants/constants.dart';

class MainState extends BaseState {
  final int selectedListId;
  final List<Event> events;
  final List<ToDoList> toDoLists;
  final List<Event> displayedEvents;
  final bool isToDoListCreated;
  final bool isSearchPressed;

  MainState({
    required this.selectedListId,
    required this.events,
    required this.displayedEvents,
    required this.toDoLists,
    required this.isToDoListCreated,
    required this.isSearchPressed,
  });

  MainState.initState()
      : selectedListId = allListsItemId,
        events = const [],
        toDoLists = const [],
        displayedEvents = const [],
        isToDoListCreated = false,
        isSearchPressed = false;

  MainState newState({
    int? selectedListId,
    List<Event>? events,
    List<Event>? displayedEvents,
    List<ToDoList>? toDoLists,
    bool? isToDoListCreated,
    bool? isSearchPressed,
  }) {
    return MainState(
      selectedListId: selectedListId ?? this.selectedListId,
      events: events ?? this.events,
      displayedEvents: displayedEvents ?? this.displayedEvents,
      toDoLists: toDoLists ?? this.toDoLists,
      isToDoListCreated: isToDoListCreated ?? this.isToDoListCreated,
      isSearchPressed: isSearchPressed ?? this.isSearchPressed,
    );
  }
}
