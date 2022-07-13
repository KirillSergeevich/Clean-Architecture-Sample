import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppTheme extends Equatable {
  final ThemeData materialTheme;

  final Color primaryBackgroundColor;
  final Color primaryTextColor;
  final Color darkTextColor;
  final Color dividerColor;
  final Color listTileColor;
  final Color bottomSheetColor;
  final Color primaryIconColor;
  final Color blurColor;
  final Color darkIconColor;

  final TextStyle primaryTextStyle;
  final TextStyle darkTextStyle;

  AppTheme({
    required this.materialTheme,
    required this.primaryBackgroundColor,
    required this.primaryTextColor,
    required this.darkTextColor,
    required this.primaryIconColor,
    required this.blurColor,
    required this.darkIconColor,
    required this.primaryTextStyle,
    required this.darkTextStyle,
    required this.dividerColor,
    required this.listTileColor,
    required this.bottomSheetColor,
  });

  @override
  List<Object> get props => [
        materialTheme,
        primaryBackgroundColor,
        primaryTextColor,
        primaryIconColor,
        blurColor,
        darkIconColor,
        darkTextColor,
        primaryTextStyle,
        darkTextStyle,
        dividerColor,
        listTileColor,
        bottomSheetColor,
      ];
}
