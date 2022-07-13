import 'package:flutter/material.dart';

abstract class BottomSheetCreator {
  static Future<dynamic> showBottomSheet({
    required Widget child,
    required BuildContext context,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          margin: const EdgeInsets.all(20.0),
          child: child,
        );
      },
    );
  }
}
