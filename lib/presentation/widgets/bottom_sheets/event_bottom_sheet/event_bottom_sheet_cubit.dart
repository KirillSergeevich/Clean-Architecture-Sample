import 'package:todo/domain/interactor_interfaces/main_interactor.dart';
import 'package:todo/presentation/base/base_cubit.dart';
import 'package:todo/presentation/extensions/date_time_extension.dart';
import 'package:todo/presentation/widgets/bottom_sheets/event_bottom_sheet/event_bottom_sheet_state.dart';

class EventBottomSheetCubit extends BaseCubit<EventBottomSheetState> {
  final MainInteractor _mainInteractor;

  EventBottomSheetCubit(this._mainInteractor) : super(EventBottomSheetState.initState());

  void initialize({required String reminderDate, required int selectedListId}) {
    emit(state.newState(reminderDate: reminderDate, selectedListId: selectedListId));
  }

  void changeSelectedListId(int selectedListId) {
    emit(state.newState(selectedListId: selectedListId));
  }

  void pickPictures() async {
    final pictures = await _mainInteractor.pickPictures();
    emit(state.newState(pictures: pictures, isPictureAdded: pictures.isNotEmpty));
  }

  void changeIsReadyClicked() {
    emit(state.newState(isReadyClicked: true));
  }

  void changeIsDescriptionChangedState(bool isDescriptionChanged) {
    emit(state.newState(isDescriptionChanged: isDescriptionChanged));
  }

  void changeReminderDate(DateTime date) {
    final reminderDate = date.formatToYMDHM();
    emit(
      state.newState(
        reminderDate: reminderDate,
        isReminderDateChanged: reminderDate != state.reminderDate,
      ),
    );
  }
}
