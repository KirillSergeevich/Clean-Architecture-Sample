import 'package:todo/data/entities/hive/to_do_list.dart';
import 'package:todo/domain/entities/to_do_list/to_do_list.dart';

extension ToDoListMapper on ToDoListDb {
  ToDoList fromHive() {
    return ToDoList(
      id: id!,
      title: title,
    );
  }
}

extension DomainToDoListMapper on ToDoList {
  ToDoListDb toHive() {
    return ToDoListDb(
      id: id,
      title: title,
    );
  }
}

extension DomainToDoListModelMapper on CreateToDoListModel {
  ToDoListDb toHive() {
    return ToDoListDb(
      title: title,
    );
  }
}
