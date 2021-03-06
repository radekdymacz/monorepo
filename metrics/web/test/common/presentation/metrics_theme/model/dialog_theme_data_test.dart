import 'package:flutter/material.dart';
import 'package:metrics/common/presentation/metrics_theme/model/dialog_theme_data.dart';
import 'package:test/test.dart';

// https://github.com/software-platform/monorepo/issues/140
// ignore_for_file: prefer_const_constructors

void main() {
  group("DialogThemeData", () {
    test(
      "creates an instance with the default colors if the parameters are not specified",
      () {
        const themeData = DialogThemeData();

        expect(themeData.primaryColor, isNotNull);
        expect(themeData.accentColor, isNotNull);
        expect(themeData.backgroundColor, isNotNull);
        expect(themeData.closeIconColor, isNotNull);
      },
    );

    test(
      "creates an instance with null text styles if the parameters are not specified",
      () {
        const themeData = DialogThemeData();

        expect(themeData.titleTextStyle, isNull);
      },
    );

    test("creates an instance with the given values", () {
      const defaultTextStyle = TextStyle();

      const primaryColor = Colors.blue;
      const accentColor = Colors.red;
      const backgroundColor = Colors.white;
      const closeIconColor = Colors.black;

      const titleTextStyle = defaultTextStyle;

      final themeData = DialogThemeData(
        primaryColor: primaryColor,
        accentColor: accentColor,
        backgroundColor: backgroundColor,
        closeIconColor: closeIconColor,
        titleTextStyle: titleTextStyle,
      );

      expect(themeData.primaryColor, equals(primaryColor));
      expect(themeData.accentColor, equals(accentColor));
      expect(themeData.backgroundColor, equals(backgroundColor));
      expect(themeData.closeIconColor, equals(closeIconColor));
      expect(themeData.titleTextStyle, equals(titleTextStyle));
    });
  });
}
