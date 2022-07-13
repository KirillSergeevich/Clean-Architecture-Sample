import 'package:todo/data/entities/hive/event.dart';
import 'package:todo/domain/entities/event/event.dart';

extension EventMapper on EventDb {
  Event fromHive() {
    return Event(
      id: id!,
      title: title,
      description: description,
      toDoListId: toDoListId,
      reminderDate: reminderDate,
      isEventCompleted: isEventCompleted,
      pictures: pictures,
    );
  }
}

extension DomainEventMapper on Event {
  EventDb toHive() {
    return EventDb(
      id: id,
      toDoListId: toDoListId,
      title: title,
      description: description,
      reminderDate: reminderDate,
      isEventCompleted: isEventCompleted,
      pictures: pictures,
    );
  }
}

extension DomainEventModelMapper on CreateEventModel {
  EventDb toHive() {
    return EventDb(
      toDoListId: toDoListId,
      title: title,
      description: description,
      reminderDate: reminderDate,
      isEventCompleted: isEventCompleted,
      pictures: pictures,
    );
  }
}
