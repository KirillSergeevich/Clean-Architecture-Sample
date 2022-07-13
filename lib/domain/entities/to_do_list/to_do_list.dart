class ToDoList {
  final int id;
  final String title;

  ToDoList({required this.id, required this.title});

  ToDoList copyWith({
    int? id,
    String? title,
  }) {
    return ToDoList(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }
}

class CreateToDoListModel {
  final String title;

  CreateToDoListModel({required this.title});
}
