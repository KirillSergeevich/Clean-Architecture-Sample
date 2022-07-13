import 'package:flutter/material.dart';
import 'package:todo/domain/entities/to_do_list/to_do_list.dart';
import 'package:todo/presentation/app/app.dart';
import 'package:todo/presentation/utils/app_typedefs.dart';

class ToDoListSelectionBottomSheet extends StatefulWidget {
  final List<ToDoList> toDoLists;
  final VoidCallback onCancel;
  final IntCallBack onSelectionConfirm;

  const ToDoListSelectionBottomSheet({
    required this.toDoLists,
    required this.onCancel,
    required this.onSelectionConfirm,
  });

  @override
  _ToDoListSelectionBottomSheetState createState() => _ToDoListSelectionBottomSheetState();
}

class _ToDoListSelectionBottomSheetState extends State<ToDoListSelectionBottomSheet> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            _ToDoListConfirmingRow(
              onCancel: widget.onCancel,
              shouldShowReadyButton: _selectedIndex != null,
              onSelectionConfirm: () {
                widget.onSelectionConfirm(widget.toDoLists[_selectedIndex!].id);
              },
            ),
            ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.toDoLists.length,
              itemBuilder: (context, index) {
                final toDoList = widget.toDoLists[index];
                final isSelected = _selectedIndex == index;
                return _ToDoListTile(
                  title: toDoList.title,
                  isSelected: isSelected,
                  onClick: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _ToDoListConfirmingRow extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSelectionConfirm;
  final bool shouldShowReadyButton;

  const _ToDoListConfirmingRow({
    required this.onCancel,
    required this.onSelectionConfirm,
    required this.shouldShowReadyButton,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onCancel,
          child: Text(localization.cancel),
        ),
        if (shouldShowReadyButton)
          GestureDetector(
            onTap: onSelectionConfirm,
            child: Text(localization.ready),
          ),
      ],
    );
  }
}

class _ToDoListTile extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onClick;
  final String title;

  const _ToDoListTile({
    required this.onClick,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onClick,
      title: Text(title),
      trailing: isSelected ? const Icon(Icons.check) : null,
    );
  }
}
