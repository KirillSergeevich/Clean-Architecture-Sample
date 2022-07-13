import 'package:todo/data/data_sources/interfaces/preference_data_source.dart';
import 'package:todo/domain/data_interfaces/theme_repository.dart';
import 'package:todo/domain/entities/theme/theme_type.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final PreferenceDataSource _preferencesDataSource;

  ThemeRepositoryImpl(this._preferencesDataSource);

  @override
  void clearThemeType() {
    _preferencesDataSource.clearThemeType();
  }

  @override
  Future<ThemeType> getThemeType() {
    return _preferencesDataSource.getThemeType();
  }

  @override
  void saveThemeType(ThemeType themeType) {
    _preferencesDataSource.saveThemeType(themeType);
  }
}
