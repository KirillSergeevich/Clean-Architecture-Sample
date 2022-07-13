import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entities/to_do_list/to_do_list.dart';
import 'package:todo/domain/utils/app_platform.dart';
import 'package:todo/presentation/app/app.dart';
import 'package:todo/presentation/di/injector.dart';
import 'package:todo/presentation/extensions/date_time_extension.dart';
import 'package:todo/presentation/utils/app_icon_sizes.dart';
import 'package:todo/presentation/utils/app_typedefs.dart';
import 'package:todo/presentation/utils/bottom_sheet_creator.dart';
import 'package:todo/presentation/utils/date_picker.dart';
import 'package:todo/presentation/utils/toast_utils.dart';
import 'package:todo/presentation/widgets/app_divider.dart';
import 'package:todo/presentation/widgets/app_icon_button.dart';
import 'package:todo/presentation/widgets/app_platform_text_field.dart';
import 'package:todo/presentation/widgets/bottom_sheets/event_bottom_sheet/event_bottom_sheet_cubit.dart';
import 'package:todo/presentation/widgets/bottom_sheets/event_bottom_sheet/event_bottom_sheet_state.dart';
import 'package:todo/presentation/widgets/bottom_sheets/to_do_list_selection_bottom_sheet.dart';

class EventBottomSheet extends StatefulWidget {
  final Function(
    String title,
    String description,
    String reminderDate,
    int selectedListId,
    List<String> pictures,
  ) onConfirm;
  final List<ToDoList> toDoLists;
  final int selectedListId;
  final String eventTitle;
  final String description;
  final bool shouldAutofocus;
  final String reminderDate;

  EventBottomSheet({
    required this.toDoLists,
    required this.onConfirm,
    required this.shouldAutofocus,
    required this.selectedListId,
    this.eventTitle = '',
    this.description = '',
    this.reminderDate = '',
  });

  @override
  _EventBottomSheetState createState() => _EventBottomSheetState();
}

class _EventBottomSheetState extends State<EventBottomSheet> {
  late TextEditingController _eventTitleController;
  late TextEditingController _descriptionController;

  final _cubit = i.get<EventBottomSheetCubit>();

  @override
  void initState() {
    _eventTitleController = TextEditingController(text: widget.eventTitle);
    _descriptionController = TextEditingController(text: widget.description);
    _cubit.initialize(reminderDate: widget.reminderDate, selectedListId: widget.selectedListId);
    super.initState();
  }

  @override
  void dispose() {
    _eventTitleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBottomSheetCubit, EventBottomSheetState>(
      bloc: _cubit,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _EventTitleTextField(
                isPictureAdded: state.isPictureAdded,
                isReadyClicked: state.isReadyClicked,
                isDescriptionChanged: state.isDescriptionChanged,
                isReminderDateChanged: state.isReminderDateChanged,
                shouldAutofocus: widget.shouldAutofocus,
                eventTitle: widget.eventTitle,
                eventTitleController: _eventTitleController,
                onConfirm: () {
                  widget.onConfirm(
                    _eventTitleController.text,
                    _descriptionController.text,
                    state.reminderDate,
                    state.selectedListId,
                    state.pictures,
                  );
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: AppDivider(),
              ),
              AppPlatformTextField(
                controller: _descriptionController,
                hintText: localization.description,
                onChanged: (description) {
                  description != widget.description
                      ? _cubit.changeIsDescriptionChangedState(true)
                      : _cubit.changeIsDescriptionChangedState(false);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: _AddingPictureRow(onClick: _cubit.pickPictures),
              ),
              _ToDoListsRow(
                onCancel: () => Navigator.pop(context),
                toDoLists: widget.toDoLists,
                selectedListId: widget.selectedListId,
                onSelectionConfirm: (selectedListId) {
                  _cubit.changeIsReadyClicked();
                  _cubit.changeSelectedListId(selectedListId);
                  Navigator.pop(context);
                },
              ),
              if (!AppPlatform.isWeb)
                (state.reminderDate.isNotEmpty)
                    ? _ReminderRow(
                        date: state.reminderDate,
                        onDatePicked: _cubit.changeReminderDate,
                      )
                    : _ReminderContainer(onDatePicked: _cubit.changeReminderDate),
            ],
          ),
        );
      },
    );
  }
}

class _AddingPictureRow extends StatelessWidget {
  final VoidCallback onClick;

  const _AddingPictureRow({required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(localization.addImage),
        AppIconButton(
          iconColor: theme.darkIconColor,
          onClick: onClick,
          icon: Icons.add,
        ),
      ],
    );
  }
}

class _ToDoListsRow extends StatefulWidget {
  final List<ToDoList> toDoLists;
  final int selectedListId;
  final IntCallBack onSelectionConfirm;
  final VoidCallback onCancel;

  _ToDoListsRow({
    required this.toDoLists,
    required this.selectedListId,
    required this.onSelectionConfirm,
    required this.onCancel,
  });

  @override
  _ToDoListsRowState createState() => _ToDoListsRowState();
}

class _ToDoListsRowState extends State<_ToDoListsRow> {
  late int _selectedListId;

  @override
  void initState() {
    setState(() {
      _selectedListId = widget.selectedListId;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showToDoListSelectionBottomSheet(
          context: context,
          toDoLists: widget.toDoLists,
          onCancel: widget.onCancel,
          onSelectionConfirm: (selectedId) {
            setState(() {
              _selectedListId = selectedId;
            });
            widget.onSelectionConfirm(_selectedListId);
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(localization.list),
          Text(
            widget.toDoLists.firstWhere((toDoList) => toDoList.id == _selectedListId).title,
          ),
        ],
      ),
    );
  }
}

void _showToDoListSelectionBottomSheet({
  required BuildContext context,
  required List<ToDoList> toDoLists,
  required IntCallBack onSelectionConfirm,
  required VoidCallback onCancel,
}) {
  BottomSheetCreator.showBottomSheet(
    context: context,
    child: ToDoListSelectionBottomSheet(
      toDoLists: toDoLists,
      onCancel: onCancel,
      onSelectionConfirm: onSelectionConfirm,
    ),
  );
}

class _ReminderRow extends StatelessWidget {
  final String date;
  final Function(DateTime date) onDatePicked;

  const _ReminderRow({required this.date, required this.onDatePicked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DatePicker.pickDate(
          context: context,
          initialDate: DateTime.now(),
          onDatePicked: onDatePicked,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(localization.reminderDate),
            Text(date),
          ],
        ),
      ),
    );
  }
}

class _ReminderContainer extends StatelessWidget {
  final Function(DateTime date) onDatePicked;

  const _ReminderContainer({required this.onDatePicked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DatePicker.pickDate(
          context: context,
          initialDate: DateTime.now(),
          onDatePicked: (date) {
            if (date.isFuture()) {
              onDatePicked(date);
            } else {
              showToast(text: localization.setReminders);
            }
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: theme.bottomSheetColor,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.notifications),
              const SizedBox(width: 8.0),
              Text(localization.addReminder),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventTitleTextField extends StatefulWidget {
  final VoidCallback onConfirm;
  final String eventTitle;
  final TextEditingController eventTitleController;
  final bool shouldAutofocus;
  final bool isReadyClicked;
  final bool isDescriptionChanged;
  final bool isReminderDateChanged;
  final bool isPictureAdded;

  const _EventTitleTextField({
    required this.onConfirm,
    required this.eventTitle,
    required this.eventTitleController,
    required this.shouldAutofocus,
    required this.isReminderDateChanged,
    required this.isDescriptionChanged,
    required this.isReadyClicked,
    required this.isPictureAdded,
  });

  @override
  __EventTitleTextFieldState createState() => __EventTitleTextFieldState();
}

class __EventTitleTextFieldState extends State<_EventTitleTextField> {
  bool _isEventTitleChanged = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppPlatformTextField(
            autofocus: widget.shouldAutofocus,
            controller: widget.eventTitleController,
            hintText: localization.eventName,
            onChanged: (title) {
              if (widget.eventTitle != title && title.isNotEmpty) {
                setState(() {
                  _isEventTitleChanged = true;
                });
              } else {
                setState(() {
                  _isEventTitleChanged = false;
                });
              }
            },
          ),
        ),
        if (_isEventTitleChanged ||
            (widget.eventTitle.isNotEmpty &&
                (widget.isDescriptionChanged ||
                    widget.isReminderDateChanged ||
                    widget.isReadyClicked ||
                    widget.isPictureAdded)))
          GestureDetector(
            onTap: widget.onConfirm,
            child: const Icon(Icons.check, size: AppIconSizes.small),
          ),
      ],
    );
  }
}
