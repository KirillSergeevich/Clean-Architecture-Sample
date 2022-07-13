import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/app/app.dart';
import 'package:todo/presentation/base/base_page.dart';
import 'package:todo/presentation/pages/settings/settings_cubit.dart';
import 'package:todo/presentation/pages/settings/settings_state.dart';
import 'package:todo/presentation/widgets/settings_item.dart';

class SettingsPage extends BasePage {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends BasePageState<SettingsPage, SettingsCubit> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(localization.settings),
          ),
          body: Column(
            children: [
              SettingsItem(
                icon: Icons.share,
                title: localization.shareApp,
                onClick: () {},
              ),
              SettingsItem(
                icon: Icons.add_alert,
                title: localization.reminders,
                onClick: () {},
              ),
              SettingsItem(
                icon: Icons.translate,
                title: localization.appTheme,
                onClick: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
