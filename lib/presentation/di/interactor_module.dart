import 'package:todo/domain/interactor_interfaces/gallery_interactor.dart';
import 'package:todo/domain/interactor_interfaces/main_interactor.dart';
import 'package:todo/domain/interactor_interfaces/theme_interactor.dart';
import 'package:todo/domain/interactors/gallery_interactor_impl.dart';
import 'package:todo/domain/interactors/main_interactor_impl.dart';
import 'package:todo/domain/interactors/theme_interactor_impl.dart';
import 'package:todo/presentation/di/injector.dart';

void initInteractorModule() {
  i.registerFactory<ThemeInteractor>(
    () => ThemeInteractorImpl(
      i.get(),
    ),
  );
  i.registerFactory<MainInteractor>(
    () => MainInteractorImpl(
      i.get(),
      i.get(),
      i.get(),
    ),
  );
  i.registerFactory<GalleryInteractor>(
    () => GalleryInteractorImpl(
      i.get(),
    ),
  );
}
