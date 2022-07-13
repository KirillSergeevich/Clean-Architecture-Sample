import 'package:todo/presentation/base/base_cubit.dart';
import 'package:todo/presentation/pages/settings/settings_state.dart';

class SettingsCubit extends BaseCubit<SettingsState> {
  SettingsCubit() : super(SettingsState.initState());
}
