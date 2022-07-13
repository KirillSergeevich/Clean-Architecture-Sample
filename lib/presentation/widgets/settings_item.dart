import 'package:flutter/material.dart';
import 'package:todo/presentation/utils/app_icon_sizes.dart';

class SettingsItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onClick;

  const SettingsItem({
    required this.icon,
    required this.title,
    required this.onClick,
  });

  @override
  _SettingsItemState createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  bool _selected = false;
  bool _clicked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(bottom: 5, left: 30, right: 30, top: 5),
      leading: _leadingIcon(),
      selected: _selected,
      title: Text(
        widget.title,
      ),
      onTap: () {
        setState(() {
          _selected = true;
        });
        _clicked = true;
        widget.onClick();
        Future.delayed(
          const Duration(milliseconds: 100),
          () => setState(() => _selected = false),
        );
      },
    );
  }

  Widget _leadingIcon() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Icon(
        widget.icon,
        size: AppIconSizes.big,
      ),
    );
  }
}
