import 'package:flutter/material.dart';
import 'package:todo/presentation/app/app.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onClick;
  final EdgeInsets padding;
  final Color? iconColor;

  AppIconButton({
    required this.icon,
    required this.onClick,
    this.padding = EdgeInsets.zero,
    iconColor,
  }) : iconColor = iconColor ?? theme.primaryIconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Padding(
        padding: padding,
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
