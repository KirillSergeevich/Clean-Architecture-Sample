import 'package:todo/domain/entities/theme/theme_type.dart';

class AppState {
  final ThemeType themeType;

  AppState({required this.themeType});

  AppState newState({ThemeType? themeType}) {
    return AppState(
      themeType: themeType ?? this.themeType,
    );
  }
}
