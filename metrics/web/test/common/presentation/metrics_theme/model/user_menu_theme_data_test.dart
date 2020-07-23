import 'package:flutter/material.dart';
import 'package:metrics/common/presentation/metrics_theme/model/user_menu_theme_data.dart';
import 'package:test/test.dart';

// https://github.com/software-platform/monorepo/issues/140
// ignore_for_file: prefer_const_constructors

void main() {
  group("UserMenuThemeData", () {
    test(
      "creates an instance with the default colors if the parameters are not specified",
          () {
        const themeData = UserMenuThemeData();

        expect(themeData.backgroundColor, isNotNull);
        expect(themeData.dividerColor, isNotNull);
        expect(themeData.activeColor, isNotNull);
      },
    );

    test(
      "creates an instance with null text style if the parameter is not specified",
          () {
        const themeData = UserMenuThemeData();

        expect(themeData.primaryTextStyle, isNull);
      },
    );

    test("creates an instance with the given values", () {
      const backgroundColor = Colors.blue;
      const activeColor = Colors.red;
      const dividerColor = Colors.black;
      const primaryTextStyle = TextStyle();

      final themeData = UserMenuThemeData(
        backgroundColor: backgroundColor,
        activeColor: activeColor,
        dividerColor: dividerColor,
        primaryTextStyle: primaryTextStyle,
      );

      expect(themeData.backgroundColor, equals(backgroundColor));
      expect(themeData.activeColor, equals(activeColor));
      expect(themeData.dividerColor, equals(dividerColor));
      expect(themeData.primaryTextStyle, equals(primaryTextStyle));
    });
  });
}
