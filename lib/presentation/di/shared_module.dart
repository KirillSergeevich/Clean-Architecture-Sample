import 'package:todo/presentation/di/injector.dart';
import 'package:todo/presentation/shared/theme/theme_shared_cubit.dart';

void initSharedModule() {
  i.registerSingleton<ThemeSharedCubit>(
    ThemeSharedCubit(i.get()),
  );
}
