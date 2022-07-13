import 'package:todo/data/data_sources/interfaces/database_data_source.dart';
import 'package:todo/domain/data_interfaces/to_do_list_repository.dart';
import 'package:todo/domain/entities/to_do_list/to_do_list.dart';

class ToDoListRepositoryImpl implements ToDoListRepository {
  final DatabaseDataSource _databaseDataSource;

  ToDoListRepositoryImpl(this._databaseDataSource);

  @override
  Future<ToDoList> createToDoListFromModel(CreateToDoListModel toDoList) {
    return _databaseDataSource.createToDoListFromModel(toDoList);
  }

  @override
  Future<List<ToDoList>> getToDoLists() {
    return _databaseDataSource.getToDoLists();
  }

  @override
  Future<void> deleteToDoList(int toDoListId) {
    return _databaseDataSource.deleteToDoList(toDoListId);
  }

  @override
  Future<void> updateToDoList(ToDoList toDoList) {
    return _databaseDataSource.updateToDoList(toDoList);
  }
}
