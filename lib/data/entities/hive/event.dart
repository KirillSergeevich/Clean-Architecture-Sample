import 'package:hive/hive.dart';

part 'event.g.dart';

@HiveType(typeId: 0)
class EventDb {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final int toDoListId;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String reminderDate;
  @HiveField(5)
  final bool isEventCompleted;
  @HiveField(6)
  final List<String> pictures;

  EventDb({
    this.id,
    required this.title,
    required this.description,
    required this.toDoListId,
    required this.reminderDate,
    required this.isEventCompleted,
    required this.pictures,
  });

  EventDb copy({
    int? id,
    int? toDoListId,
    String? title,
    String? description,
    String? reminderDate,
    bool? isEventCompleted,
    List<String>? pictures,
  }) {
    return EventDb(
      id: id ?? this.id,
      toDoListId: toDoListId ?? this.toDoListId,
      title: title ?? this.title,
      description: description ?? this.description,
      reminderDate: reminderDate ?? this.reminderDate,
      isEventCompleted: isEventCompleted ?? this.isEventCompleted,
      pictures: pictures ?? this.pictures,
    );
  }
}
