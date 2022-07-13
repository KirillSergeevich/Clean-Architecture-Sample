import 'package:flutter/material.dart';

class EditingBottomSheet extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final String editTitle;
  final String deleteTitle;

  const EditingBottomSheet({
    required this.onEdit,
    required this.onDelete,
    required this.editTitle,
    required this.deleteTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: onEdit,
          leading: const Icon(Icons.edit),
          title: Text(editTitle),
        ),
        ListTile(
          onTap: onDelete,
          leading: const Icon(Icons.delete),
          title: Text(deleteTitle),
        ),
      ],
    );
  }
}
