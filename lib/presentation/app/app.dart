import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entities/theme/theme_type.dart';
import 'package:todo/l10n/app_localizations.dart';
import 'package:todo/presentation/app/app_cubit.dart';
import 'package:todo/presentation/app/app_state.dart';
import 'package:todo/presentation/di/injector.dart';
import 'package:todo/presentation/pages/main/main_page.dart';
import 'package:todo/presentation/theme/app_theme.dart';
import 'package:todo/presentation/theme/app_themes.dart';
import 'package:todo/presentation/theme/theme_provider.dart';

final globalRootNavKey = GlobalKey<NavigatorState>();

AppLocalizations get localization => AppLocalizations.of(globalRootNavKey.currentContext!)!;

AppTheme get theme => ThemeProvider.of(globalRootNavKey.currentContext!).theme;

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final AppCubit _cubit = i.get<AppCubit>();

  @override
  void initState() {
    super.initState();
    if (kReleaseMode) {
      services.SystemChrome.setPreferredOrientations([
        services.DeviceOrientation.portraitUp,
        services.DeviceOrientation.portraitDown,
      ]);
    }
    _cubit.onAppStarted();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      bloc: _cubit,
      builder: (context, state) {
        return ThemeProvider(
          theme: state.themeType == ThemeType.dark ? darkTheme : lightTheme,
          child: Builder(
            builder: (context) {
              return MaterialApp(
                navigatorKey: globalRootNavKey,
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: const [
                  ...AppLocalizations.localizationsDelegates,
                ],
                theme: state.themeType == ThemeType.dark
                    ? darkTheme.materialTheme
                    : lightTheme.materialTheme,
                builder: BotToastInit(),
                home: MainPage(),
              );
            },
          ),
        );
      },
    );
  }
}
