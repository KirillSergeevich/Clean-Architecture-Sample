import 'package:todo/presentation/base/base_state.dart';

class EventBottomSheetState extends BaseState {
  final String reminderDate;
  final bool isReminderDateChanged;
  final bool isDescriptionChanged;
  final bool isReadyClicked;
  final bool isPictureAdded;
  final int selectedListId;
  final List<String> pictures;

  EventBottomSheetState({
    required this.reminderDate,
    required this.isReminderDateChanged,
    required this.isDescriptionChanged,
    required this.selectedListId,
    required this.isReadyClicked,
    required this.pictures,
    required this.isPictureAdded,
  });

  EventBottomSheetState.initState({
    this.reminderDate = '',
    this.pictures = const [],
    this.isReminderDateChanged = false,
    this.isDescriptionChanged = false,
    this.isReadyClicked = false,
    this.isPictureAdded = false,
    this.selectedListId = 0,
  });

  EventBottomSheetState newState({
    List<String>? pictures,
    String? reminderDate,
    bool? isReminderDateChanged,
    bool? isDescriptionChanged,
    bool? isReadyClicked,
    bool? isPictureAdded,
    int? selectedListId,
  }) {
    return EventBottomSheetState(
      pictures: pictures ?? this.pictures,
      reminderDate: reminderDate ?? this.reminderDate,
      isReminderDateChanged: isReminderDateChanged ?? this.isReminderDateChanged,
      isDescriptionChanged: isDescriptionChanged ?? this.isDescriptionChanged,
      isReadyClicked: isReadyClicked ?? this.isReadyClicked,
      isPictureAdded: isPictureAdded ?? this.isPictureAdded,
      selectedListId: selectedListId ?? this.selectedListId,
    );
  }
}
