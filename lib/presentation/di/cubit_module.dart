import 'package:todo/presentation/app/app_cubit.dart';
import 'package:todo/presentation/di/injector.dart';
import 'package:todo/presentation/pages/gallery/gallery_cubit.dart';
import 'package:todo/presentation/pages/main/main_cubit.dart';
import 'package:todo/presentation/pages/settings/settings_cubit.dart';
import 'package:todo/presentation/widgets/bottom_sheets/event_bottom_sheet/event_bottom_sheet_cubit.dart';

void initCubitModule() {
  i.registerFactory(
    () => AppCubit(
      i.get(),
    ),
  );
  i.registerFactory(
    () => MainCubit(
      i.get(),
    ),
  );
  i.registerFactory(
    () => SettingsCubit(),
  );
  i.registerFactory(
    () => EventBottomSheetCubit(
      i.get(),
    ),
  );
  i.registerFactory(
    () => GalleryCubit(
      i.get(),
    ),
  );
}
