import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entities/theme/theme_type.dart';
import 'package:todo/presentation/app/app_state.dart';
import 'package:todo/presentation/shared/theme/theme_shared_cubit.dart';

class AppCubit extends Cubit<AppState> {
  final ThemeSharedCubit _themeCubit;

  AppCubit(this._themeCubit) : super(AppState(themeType: _themeCubit.state.themeType));

  void changeTheme(ThemeType themeType) {
    emit(state.newState(themeType: themeType));
  }

  void onAppStarted() {
    _themeCubit.stream.listen((state) {
      changeTheme(state.themeType);
    });
  }
}
