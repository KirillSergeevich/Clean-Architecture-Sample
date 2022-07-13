import 'package:todo/domain/entities/to_do_list/to_do_list.dart';

abstract class ToDoListRepository {
  Future<List<ToDoList>> getToDoLists();

  Future<ToDoList> createToDoListFromModel(CreateToDoListModel toDoList);

  Future<void> updateToDoList(ToDoList toDoList);

  Future<void> deleteToDoList(int toDoListId);
}
