import 'package:flutter/material.dart';
import 'package:todo/data/data_sources/database_data_source_impl.dart';
import 'package:todo/platform/notification_client_impl.dart';
import 'package:todo/presentation/app/app.dart';
import 'package:todo/presentation/di/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseDataSourceImpl.initializeDb();
  await NotificationClientImpl.initNotifications();
  initInjector();
  runApp(App());
}
