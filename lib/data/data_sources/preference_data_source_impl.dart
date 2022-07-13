import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/data/data_sources/interfaces/preference_data_source.dart';
import 'package:todo/domain/entities/theme/theme_type.dart';

class PreferenceDataSourceImpl implements PreferenceDataSource {
  static const _themeType = 'themeType';

  Future<SharedPreferences> get _prefs async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<ThemeType> getThemeType() {
    return _prefs
        .then((prefs) => prefs.getInt(_themeType))
        .then((value) => ThemeType.values[value ?? 1]);
  }

  @override
  void saveThemeType(ThemeType themeType) {
    _prefs.then((prefs) => prefs.setInt(_themeType, themeType.index));
  }

  @override
  void clearThemeType() {
    _prefs.then((prefs) => prefs.setInt(_themeType, 1));
  }
}
