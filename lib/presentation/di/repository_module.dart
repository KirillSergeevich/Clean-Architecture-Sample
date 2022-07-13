import 'package:todo/data/repositories/event_repository_impl.dart';
import 'package:todo/data/repositories/theme_repository_impl.dart';
import 'package:todo/data/repositories/to_do_list_repository_impl.dart';
import 'package:todo/domain/data_interfaces/event_repository.dart';
import 'package:todo/domain/data_interfaces/theme_repository.dart';
import 'package:todo/domain/data_interfaces/to_do_list_repository.dart';
import 'package:todo/presentation/di/injector.dart';

void initRepositoryModule() {
  i.registerSingleton<ThemeRepository>(
    ThemeRepositoryImpl(
      i.get(),
    ),
  );
  i.registerSingleton<EventRepository>(
    EventRepositoryImpl(
      i.get(),
      i.get(),
    ),
  );
  i.registerSingleton<ToDoListRepository>(
    ToDoListRepositoryImpl(
      i.get(),
    ),
  );
}
