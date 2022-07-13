import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/domain/utils/app_platform.dart';
import 'package:todo/presentation/app/app.dart';
import 'package:todo/presentation/utils/app_typedefs.dart';

class AppPlatformTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final StringCallback? onChanged;
  final EdgeInsetsGeometry padding;
  final bool autofocus;
  final Brightness? keyboardAppearance;
  final TextStyle? textStyle;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final TextInputAction? textInputAction;
  final Color? cursorColor;

  AppPlatformTextField({
    required this.controller,
    this.hintText = '',
    this.onChanged,
    this.focusNode,
    this.keyboardAppearance,
    this.padding = EdgeInsets.zero,
    this.autofocus = false,
    this.textAlign = TextAlign.start,
    this.textInputAction,
    cursorColor,
    textStyle,
  })  : textStyle = textStyle ?? theme.darkTextStyle,
        cursorColor = cursorColor ?? theme.darkTextColor;

  @override
  Widget build(BuildContext context) {
    if (AppPlatform.isAndroid) {
      return TextField(
        focusNode: focusNode,
        keyboardAppearance: keyboardAppearance,
        controller: controller,
        cursorColor: cursorColor,
        style: textStyle,
        autofocus: autofocus,
        maxLines: null,
        textAlign: textAlign,
        cursorHeight: 20,
        textInputAction: textInputAction,
        textCapitalization: TextCapitalization.sentences,
        onChanged: (text) => onChanged?.call(text),
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: textStyle,
          fillColor: Colors.transparent,
          contentPadding: padding,
          border: InputBorder.none,
        ),
      );
    } else {
      return CupertinoTextField(
        controller: controller,
        focusNode: focusNode,
        keyboardAppearance: keyboardAppearance,
        cursorColor: cursorColor,
        style: textStyle,
        autofocus: autofocus,
        maxLines: null,
        textAlign: textAlign,
        textInputAction: textInputAction,
        placeholder: hintText,
        placeholderStyle: textStyle,
        cursorHeight: 20,
        decoration: const BoxDecoration(color: Colors.transparent),
        padding: padding,
        textCapitalization: TextCapitalization.sentences,
        onChanged: (text) => onChanged?.call(text),
      );
    }
  }
}
