import 'package:todo/domain/data_interfaces/theme_repository.dart';
import 'package:todo/domain/entities/theme/theme_type.dart';
import 'package:todo/domain/interactor_interfaces/theme_interactor.dart';

class ThemeInteractorImpl implements ThemeInteractor {
  final ThemeRepository _themeRepository;

  ThemeInteractorImpl(this._themeRepository);

  @override
  void saveTheme(ThemeType themeType) {
    _themeRepository.saveThemeType(themeType);
  }

  @override
  Future<ThemeType> getCurrentTheme() async {
    return _themeRepository.getThemeType();
  }
}
