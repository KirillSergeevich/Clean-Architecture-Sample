import 'package:flutter/material.dart';
import 'package:todo/presentation/app/app.dart';

class AppDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: theme.dividerColor,
      thickness: 1.5,
      height: 1.5,
    );
  }
}
