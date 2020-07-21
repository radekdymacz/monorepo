import 'package:flutter/material.dart';

class UserMenuThemeData {
  final Color backgroundColor;

  final Color activeColor;

  final Color dividerColor;

  final TextStyle primaryTextStyle;

  const UserMenuThemeData({
    this.backgroundColor = Colors.black,
    this.dividerColor = Colors.grey,
    this.activeColor = Colors.grey,
    this.primaryTextStyle,
  });
}
