import 'package:todo/domain/client_interfaces/notification_client.dart';
import 'package:todo/domain/client_interfaces/picture_picker_client.dart';
import 'package:todo/platform/notification_client_impl.dart';
import 'package:todo/platform/picture_picker_client_impl.dart';
import 'package:todo/presentation/di/injector.dart';

void initClientModule() {
  i.registerSingleton<NotificationClient>(
    NotificationClientImpl(),
  );
  i.registerSingleton<PicturePickerClient>(
    PicturePickerClientImpl(),
  );
}
