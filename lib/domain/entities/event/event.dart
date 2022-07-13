class Event {
  final int id;
  final int toDoListId;
  final String title;
  final String description;
  final String reminderDate;
  final bool isEventCompleted;
  final List<String> pictures;

  Event({
    required this.id,
    required this.toDoListId,
    required this.title,
    required this.description,
    required this.reminderDate,
    required this.isEventCompleted,
    required this.pictures,
  });

  Event copyWith({
    int? id,
    int? toDoListId,
    String? title,
    String? description,
    String? reminderDate,
    bool? isEventCompleted,
    List<String>? pictures,
  }) {
    return Event(
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

class CreateEventModel {
  final int toDoListId;
  final String title;
  final String description;
  final String reminderDate;
  final bool isEventCompleted;
  final List<String> pictures;

  CreateEventModel({
    required this.toDoListId,
    required this.title,
    required this.description,
    required this.reminderDate,
    required this.isEventCompleted,
    required this.pictures,
  });
}
