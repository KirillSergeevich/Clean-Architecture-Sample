import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entities/theme/theme_type.dart';
import 'package:todo/domain/interactor_interfaces/theme_interactor.dart';

class ThemeSharedCubit extends Cubit<ThemeState> {
  final ThemeInteractor _themeInteractor;

  ThemeSharedCubit(this._themeInteractor) : super(ThemeState()) {
    _init();
  }

  void setTheme(ThemeType themeType) {
    _themeInteractor.saveTheme(themeType);
    emit(state.newState(themeType: themeType, previousThemeType: state.themeType));
  }

  void dispose() => _init();

  void _init() async {
    final initialThemeType = await _themeInteractor.getCurrentTheme();
    emit(state.newState(themeType: initialThemeType, previousThemeType: initialThemeType));
  }
}

class ThemeState {
  final ThemeType themeType;
  final ThemeType previousThemeType;

  ThemeState({this.themeType = ThemeType.dark, this.previousThemeType = ThemeType.dark});

  ThemeState newState({
    ThemeType? themeType,
    required ThemeType previousThemeType,
  }) {
    return ThemeState(themeType: themeType ?? this.themeType, previousThemeType: previousThemeType);
  }
}
