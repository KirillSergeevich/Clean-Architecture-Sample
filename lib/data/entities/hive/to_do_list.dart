import 'package:hive/hive.dart';

part 'to_do_list.g.dart';

@HiveType(typeId: 1)
class ToDoListDb {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String title;

  ToDoListDb({this.id, required this.title});

  ToDoListDb copy({
    int? id,
    String? title,
  }) {
    return ToDoListDb(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }
}
