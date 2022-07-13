import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/data_sources/interfaces/database_data_source.dart';
import 'package:todo/data/entities/hive/event.dart';
import 'package:todo/data/entities/hive/to_do_list.dart';
import 'package:todo/data/mappers/event_mapper.dart';
import 'package:todo/data/mappers/to_do_list_mapper.dart';
import 'package:todo/domain/entities/event/event.dart';
import 'package:todo/domain/entities/to_do_list/to_do_list.dart';

class DatabaseDataSourceImpl extends DatabaseDataSource {
  /// region TAG
  static const _toDoListTag = 'eventsList';
  static const _eventTag = 'event';

  /// endregion

  /// region Box
  static late final Box<EventDb> _eventBox;
  static late final Box<ToDoListDb> _toDoListBox;

  ///endregion

  static Future<void> initializeDb() async {
    await Hive.initFlutter();
    Hive.registerAdapter(EventDbAdapter());
    Hive.registerAdapter(ToDoListDbAdapter());
    _eventBox = await Hive.openBox<EventDb>(_eventTag);
    _toDoListBox = await Hive.openBox<ToDoListDb>(_toDoListTag);
  }

  @override
  Future<Event> createEventFromModel(CreateEventModel event) async {
    final toCreate = event.toHive();
    final id = await _eventBox.add(toCreate);
    final created = toCreate.copy(id: id);
    await _eventBox.put(id, created);
    return created.fromHive();
  }

  @override
  Future<void> deleteEvent(int eventId) async {
    await _eventBox.delete(eventId);
  }

  @override
  Future<void> updateEvent(Event event) async {
    await _eventBox.put(event.id, event.toHive());
  }

  @override
  Future<List<ToDoList>> getToDoLists() async {
    final result = await _toDoListBox.values.map((e) => e.fromHive()).toList();
    return result;
  }

  @override
  Future<List<Event>> getEvents(int selectedList) async {
    final result = await _eventBox.values.map((e) => e.fromHive()).toList();
    return result;
  }

  @override
  Future<void> dispose() async {
    await _eventBox.close();
    await _toDoListBox.close();
  }

  @override
  Future<ToDoList> createToDoListFromModel(CreateToDoListModel toDoList) async {
    final toCreate = toDoList.toHive();
    final id = await _toDoListBox.add(toCreate);
    final created = toCreate.copy(id: id);
    await _toDoListBox.put(id, created);
    return created.fromHive();
  }

  @override
  Future<void> deleteEventsByToDoListId(int toDoListId) async {
    _eventBox.values.where((event) => event.toDoListId == toDoListId).toList().forEach(
      (toDoList) async {
        await _eventBox.delete(toDoList.id);
      },
    );
  }

  @override
  Future<void> deleteToDoList(int toDoListId) async {
    await _toDoListBox.delete(toDoListId);
  }

  @override
  Future<void> updateToDoList(ToDoList toDoList) async {
    await _toDoListBox.put(toDoList.id, toDoList.toHive());
  }
}
