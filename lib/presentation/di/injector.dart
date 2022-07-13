import 'package:get_it/get_it.dart';
import 'package:todo/presentation/di/client_module.dart';
import 'package:todo/presentation/di/cubit_module.dart';
import 'package:todo/presentation/di/data_source_module.dart';
import 'package:todo/presentation/di/interactor_module.dart';
import 'package:todo/presentation/di/repository_module.dart';
import 'package:todo/presentation/di/shared_module.dart';

GetIt get i => GetIt.instance;

void initInjector() {
  initClientModule();
  initDataSourceModule();
  initRepositoryModule();
  initInteractorModule();
  initSharedModule();
  initCubitModule();
}
