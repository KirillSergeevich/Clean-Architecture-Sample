import 'package:todo/domain/entities/theme/theme_type.dart';

abstract class ThemeInteractor {
  void saveTheme(ThemeType themeType);

  Future<ThemeType> getCurrentTheme();
}
