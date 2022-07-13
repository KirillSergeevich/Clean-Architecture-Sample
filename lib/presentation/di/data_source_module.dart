import 'package:todo/data/data_sources/database_data_source_impl.dart';
import 'package:todo/data/data_sources/interfaces/database_data_source.dart';
import 'package:todo/data/data_sources/interfaces/preference_data_source.dart';
import 'package:todo/data/data_sources/preference_data_source_impl.dart';
import 'package:todo/presentation/di/injector.dart';

void initDataSourceModule() {
  i.registerSingleton<PreferenceDataSource>(
    PreferenceDataSourceImpl(),
  );
  i.registerSingleton<DatabaseDataSource>(
    DatabaseDataSourceImpl(),
  );
}
