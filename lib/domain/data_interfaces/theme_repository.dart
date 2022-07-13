import 'package:todo/domain/entities/theme/theme_type.dart';

abstract class ThemeRepository {
  Future<ThemeType> getThemeType();

  void clearThemeType();

  void saveThemeType(ThemeType themeType);
}
