import 'package:flutter/material.dart';
import 'package:todo/presentation/app/app.dart';
import 'package:todo/presentation/utils/app_icon_sizes.dart';
import 'package:todo/presentation/utils/app_typedefs.dart';
import 'package:todo/presentation/widgets/app_platform_text_field.dart';

class ToDoListBottomSheet extends StatefulWidget {
  final StringCallback onConfirm;

  const ToDoListBottomSheet({required this.onConfirm});

  @override
  _ToDoListBottomSheetState createState() => _ToDoListBottomSheetState();
}

class _ToDoListBottomSheetState extends State<ToDoListBottomSheet> {
  late TextEditingController _textEditingController;

  bool _isEmpty = true;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppPlatformTextField(
            controller: _textEditingController,
            hintText: localization.listName,
            onChanged: (text) {
              if (text.isEmpty) {
                setState(() {
                  _isEmpty = true;
                });
              } else {
                setState(() {
                  _isEmpty = false;
                });
              }
            },
          ),
        ),
        if (!_isEmpty)
          GestureDetector(
            onTap: () {
              widget.onConfirm(_textEditingController.text);
              Navigator.pop(context);
            },
            child: Icon(
              Icons.check,
              size: AppIconSizes.small,
              color: theme.darkTextColor,
            ),
          ),
      ],
    );
  }
}
