import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entities/event/event.dart';
import 'package:todo/domain/entities/to_do_list/to_do_list.dart';
import 'package:todo/presentation/app/app.dart';
import 'package:todo/presentation/base/base_page.dart';
import 'package:todo/presentation/pages/gallery/gallery_page.dart';
import 'package:todo/presentation/pages/main/constants/constants.dart';
import 'package:todo/presentation/pages/main/main_cubit.dart';
import 'package:todo/presentation/pages/main/main_state.dart';
import 'package:todo/presentation/pages/settings/settings_page.dart';
import 'package:todo/presentation/utils/app_typedefs.dart';
import 'package:todo/presentation/utils/bottom_sheet_creator.dart';
import 'package:todo/presentation/widgets/app_icon_button.dart';
import 'package:todo/presentation/widgets/app_platform_text_field.dart';
import 'package:todo/presentation/widgets/bottom_sheets/editing_bottom_sheet.dart';
import 'package:todo/presentation/widgets/bottom_sheets/event_bottom_sheet/event_bottom_sheet.dart';
import 'package:todo/presentation/widgets/bottom_sheets/to_do_list_bottom_sheet.dart';

class MainPage extends BasePage {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends BasePageState<MainPage, MainCubit> {
  late TextEditingController _searchEditingController;

  @override
  void initState() {
    _searchEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      bloc: cubit,
      listener: (context, state) {
        if (state.isToDoListCreated) {
          cubit.changeSelectedList(state.toDoLists[toDoListsFirstIndex].id);
          cubit.changeIsToDoListCreated(false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: state.isSearchPressed
                ? _MainSearchTextField(
                    onChanged: cubit.filterEventsBySearchText,
                    searchEditingController: _searchEditingController,
                    onClick: () {
                      _searchEditingController.clear();
                      cubit.changeIsSearchPressed(false);
                      cubit.restoreDisplayedEvents();
                    },
                  )
                : _MainDropDownButton(
                    selectedListId: state.selectedListId,
                    toDoLists: state.toDoLists,
                    onChanged: _onSelectedListChanged,
                    onConfirm: (title, toDoList) {
                      cubit.updateToDoList(title: title, currentToDoList: toDoList);
                      cubit.changeSelectedList(toDoList.id);
                    },
                    onDelete: (selectedListId) {
                      if (selectedListId == state.selectedListId) {
                        cubit.changeSelectedList(allListsItemId);
                      }
                      cubit.deleteToDoList(selectedListId);
                    },
                  ),
            actions: [
              AppIconButton(
                padding: const EdgeInsets.only(right: 15.0),
                icon: Icons.search,
                onClick: () => cubit.changeIsSearchPressed(true),
              ),
              AppIconButton(
                padding: const EdgeInsets.only(right: 15.0),
                icon: Icons.settings,
                onClick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                },
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: state.displayedEvents.length,
            itemBuilder: (context, index) {
              final event = state.displayedEvents[index];
              return event.isEventCompleted
                  ? Container()
                  : _MainEventListTile(
                      title: event.title,
                      isEventCompleted: event.isEventCompleted,
                      onEventCompleted: () {
                        cubit.updateEvent(currentEvent: event, isEventCompleted: true);
                      },
                      onDoubleClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GalleryPage(event: event)),
                        );
                      },
                      onClick: () {
                        _showEventEditingBottomSheet(
                          event: event,
                          toDoLists: state.toDoLists,
                          selectedListId: event.toDoListId,
                          shouldAutoFocus: false,
                        );
                      },
                      onLongClick: () {
                        _showEditingBottomSheet(
                          event: event,
                          toDoLists: state.toDoLists,
                          selectedListId: state.selectedListId,
                        );
                      },
                    );
            },
          ),
          floatingActionButton: _MainFloatingActionButton(
            onClick: () {
              _showMainCreatingBottomSheet(
                selectedListId: state.selectedListId,
                toDoLists: state.toDoLists,
              );
            },
          ),
        );
      },
    );
  }

  void _showEventEditingBottomSheet({
    required Event event,
    required List<ToDoList> toDoLists,
    required int selectedListId,
    required bool shouldAutoFocus,
  }) {
    BottomSheetCreator.showBottomSheet(
      context: context,
      child: EventBottomSheet(
        toDoLists: toDoLists,
        selectedListId: selectedListId,
        shouldAutofocus: shouldAutoFocus,
        eventTitle: event.title,
        description: event.description,
        reminderDate: event.reminderDate,
        onConfirm: (title, description, reminderDate, selectedListId, pictures) {
          cubit.updateEvent(
            title: title,
            description: description,
            currentEvent: event,
            reminderDate: reminderDate,
            selectedListId: selectedListId,
            pictures: pictures,
          );
        },
      ),
    );
  }

  void _onSelectedListChanged(int selectedListId) {
    if (selectedListId == addListItemId) {
      BottomSheetCreator.showBottomSheet(
        context: context,
        child: ToDoListBottomSheet(
          onConfirm: cubit.createToDoList,
        ),
      );
    } else {
      cubit.changeSelectedList(selectedListId);
    }
  }

  void _showEditingBottomSheet({
    required Event event,
    required List<ToDoList> toDoLists,
    required int selectedListId,
  }) {
    BottomSheetCreator.showBottomSheet(
      context: context,
      child: EditingBottomSheet(
        deleteTitle: localization.deleteEvent,
        editTitle: localization.editEvent,
        onDelete: () {
          cubit.deleteEvent(event.id);
          Navigator.pop(context);
        },
        onEdit: () {
          Navigator.pop(context);
          _showEventEditingBottomSheet(
            event: event,
            toDoLists: toDoLists,
            selectedListId: selectedListId,
            shouldAutoFocus: true,
          );
        },
      ),
    );
  }

  void _showMainCreatingBottomSheet({
    required List<ToDoList> toDoLists,
    required int selectedListId,
  }) {
    BottomSheetCreator.showBottomSheet(
      context: context,
      child: EventBottomSheet(
        selectedListId: selectedListId,
        toDoLists: toDoLists,
        shouldAutofocus: true,
        onConfirm: (title, description, reminderDate, selectedListId, pictures) {
          cubit.createEvent(
            title: title,
            description: description,
            reminderDate: reminderDate,
            selectedListId: selectedListId,
            pictures: pictures,
          );
        },
      ),
    );
  }
}

class _MainDropDownButton extends StatelessWidget {
  final int selectedListId;
  final List<ToDoList> toDoLists;
  final IntCallBack onChanged;
  final IntCallBack onDelete;
  final Function(String title, ToDoList toDoList) onConfirm;

  const _MainDropDownButton({
    required this.selectedListId,
    required this.toDoLists,
    required this.onChanged,
    required this.onDelete,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        style: TextStyle(color: theme.darkTextColor),
        iconEnabledColor: theme.primaryTextColor,
        value: selectedListId,
        selectedItemBuilder: (context) {
          return [
            ..._displayedToDoLists.map(
              (toDoList) {
                return _DropDownMenuItem(
                  itemValue: toDoList.id,
                  title: toDoList.title,
                  textColor: theme.primaryTextColor,
                  onLongClick: () {
                    _showToDoListEditingBottomSheet(
                      toDoList: toDoList,
                      context: context,
                      onDelete: onDelete,
                      onConfirm: onConfirm,
                    );
                  },
                );
              },
            ),
          ];
        },
        onChanged: (value) {
          if (value != null) onChanged(value as int);
        },
        items: [
          if (toDoLists.isNotEmpty)
            ..._displayedToDoLists.map(
              (toDoList) {
                return _DropDownMenuItem(
                  itemValue: toDoList.id,
                  title: toDoList.title,
                  textColor: theme.darkTextColor,
                  onLongClick: () {
                    _showToDoListEditingBottomSheet(
                      toDoList: toDoList,
                      context: context,
                      onDelete: onDelete,
                      onConfirm: onConfirm,
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }

  List<ToDoList> get _displayedToDoLists {
    return <ToDoList>[
      ...toDoLists,
      ToDoList(id: addListItemId, title: localization.addList),
    ];
  }

  void _showToDoListEditingBottomSheet({
    required ToDoList toDoList,
    required BuildContext context,
    required IntCallBack onDelete,
    required Function(String title, ToDoList toDoList) onConfirm,
  }) {
    BottomSheetCreator.showBottomSheet(
      context: context,
      child: EditingBottomSheet(
        deleteTitle: localization.deleteList,
        editTitle: localization.editList,
        onDelete: () {
          onDelete(toDoList.id);
          Navigator.pop(context); // close EditingBottomSheet
          Navigator.pop(context); // close _MainDropDownButton
        },
        onEdit: () {
          Navigator.pop(context); // close EditingBottomSheet
          Navigator.pop(context); // close _MainDropDownButton
          BottomSheetCreator.showBottomSheet(
            context: context,
            child: ToDoListBottomSheet(
              onConfirm: (title) => onConfirm(title, toDoList),
            ),
          );
        },
      ),
    );
  }
}

class _DropDownMenuItem extends DropdownMenuItem<int> {
  final VoidCallback onLongClick;
  final String title;
  final int itemValue;
  final Color textColor;

  _DropDownMenuItem({
    required this.onLongClick,
    required this.title,
    required this.itemValue,
    required this.textColor,
  }) : super(
          value: itemValue,
          child: GestureDetector(
            onLongPress: onLongClick,
            child: Container(
              width: 100,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: textColor),
              ),
            ),
          ),
        );
}

class _MainSearchTextField extends StatelessWidget {
  final VoidCallback onClick;
  final StringCallback onChanged;
  final TextEditingController searchEditingController;

  const _MainSearchTextField({
    required this.onClick,
    required this.onChanged,
    required this.searchEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppIconButton(
          padding: const EdgeInsets.only(right: 10.0),
          icon: Icons.arrow_back,
          onClick: onClick,
        ),
        Expanded(
          child: AppPlatformTextField(
            hintText: localization.search,
            textStyle: theme.primaryTextStyle,
            autofocus: true,
            onChanged: onChanged,
            controller: searchEditingController,
            cursorColor: theme.primaryTextColor,
          ),
        ),
      ],
    );
  }
}

class _MainEventListTile extends StatelessWidget {
  final VoidCallback onLongClick;
  final VoidCallback onClick;
  final VoidCallback onDoubleClick;
  final VoidCallback onEventCompleted;
  final bool isEventCompleted;
  final String title;

  const _MainEventListTile({
    required this.onDoubleClick,
    required this.onLongClick,
    required this.title,
    required this.onClick,
    required this.onEventCompleted,
    required this.isEventCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onDoubleTap: onDoubleClick,
        onTap: onClick,
        onLongPress: onLongClick,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            color: theme.listTileColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 20.0, bottom: 20.0),
                child: Text(
                  title,
                  style: theme.primaryTextStyle,
                ),
              ),
              Theme(
                data: ThemeData(unselectedWidgetColor: theme.primaryTextColor),
                child: Checkbox(
                  checkColor: theme.primaryTextColor,
                  value: isEventCompleted,
                  activeColor: Colors.transparent,
                  onChanged: (value) => onEventCompleted(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainFloatingActionButton extends StatelessWidget {
  final VoidCallback onClick;

  const _MainFloatingActionButton({required this.onClick});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: onClick,
    );
  }
}
