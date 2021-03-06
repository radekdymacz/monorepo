// This is a Flutter Web Driver test
// https://github.com/flutter/flutter/pull/45951

import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:metrics/auth/presentation/strings/auth_strings.dart';
import 'package:metrics/common/presentation/strings/common_strings.dart';
import 'package:metrics/dashboard/presentation/strings/dashboard_strings.dart';
import 'package:test/test.dart';

import 'arguments/model/user_credentials.dart';

void main() {
  group(
    "Flutter driver test",
    () {
      FlutterDriver driver;

      setUpAll(() async {
        driver = await WebFlutterDriver.connectWeb();
      });

      tearDownAll(() async {
        await driver?.close();
      });

      group("LoginPage", () {
        test("shows an authentication form", () async {
          await _authFormExists(driver);
        });

        test("can authenticate in the app using an email and a password",
            () async {
          await _authFormExists(driver);
          await _login(driver);
          await _authFormAbsent(driver);
          await driver.waitFor(find.byType('DashboardPage'));
        });

        test("can log out from the app", () async {
          await driver.waitUntilNoTransientCallbacks(
              timeout: const Duration(seconds: 2));
          await driver.tap(find.byTooltip(CommonStrings.openUserMenu));
          await driver.waitFor(find.text(CommonStrings.logOut));
          await driver.tap(find.text(CommonStrings.logOut));
          await driver.waitUntilNoTransientCallbacks(
              timeout: const Duration(seconds: 2));
          await _authFormExists(driver);
        });
      });

      group("DashboardPage", () {
        setUpAll(() async {
          await _authFormExists(driver);
          await _login(driver);
          await _authFormAbsent(driver);
        });

        test(
          "loads and shows the projects",
          () async {
            await driver.waitFor(find.byType('ProjectMetricsTile'));
          },
        );

        test(
          "loads and displays coverage metric",
          () async {
            await driver.waitFor(find.text(DashboardStrings.coverage));
            await driver.waitFor(find.byType('CirclePercentage'));
          },
        );

        test(
          "loads and displays the performance metric ",
          () async {
            await driver.waitFor(find.text(DashboardStrings.performance));

            await driver.waitFor(find.byType('PerformanceSparklineGraph'));
          },
        );

        test(
          "loads and shows the build number metric",
          () async {
            await driver.waitFor(find.text(DashboardStrings.builds));

            await driver.waitFor(find.byType('BuildNumberScorecard'));
          },
        );

        test(
          "loads and shows the build result metrics",
          () async {
            await driver.waitFor(find.byType('BuildResultBarGraph'));
          },
        );

        test("shows a search project input", () async {
          await driver.waitFor(find.byType('ProjectSearchInput'));
        });

        test("project search input filters list of projects", () async {
          await driver.waitForAbsent(
            find.text(DashboardStrings.noConfiguredProjects),
          );

          await driver.tap(find.byType('ProjectSearchInput'));
          await driver.enterText('_test_filters_project_name_');

          await driver.waitFor(
            find.byType('NoSearchResultsPlaceholder'),
          );
          await driver.waitFor(
            find.text(DashboardStrings.noSearchResults),
          );
        });
      });

      group("ProjectGroup page", () {
        setUpAll(() async {
          await driver.tap(find.byTooltip(CommonStrings.openUserMenu));
          await driver.waitFor(find.text(CommonStrings.projectGroups));
          await driver.tap(find.text(CommonStrings.projectGroups));

          await driver.waitUntilNoTransientCallbacks(
            timeout: const Duration(seconds: 2),
          );
        });

        test("shows add project group card button", () async {
          await driver.tap(find.byTooltip(CommonStrings.openUserMenu));

          await driver.waitFor(find.byType('AddProjectGroupCard'));
        });
      });
    },
  );
}

Future<void> _login(FlutterDriver driver) async {
  final environment = Platform.environment;
  final credentials = UserCredentials.fromMap(environment);

  await driver.tap(find.byValueKey(AuthStrings.email));
  await driver.enterText(credentials.email);
  await driver.tap(find.byValueKey(AuthStrings.password));
  await driver.enterText(credentials.password);
  await driver.tap(find.byValueKey(AuthStrings.signIn));
}

Future<void> _authFormExists(FlutterDriver driver) async {
  await driver.waitFor(find.byType('AuthForm'));
}

Future<void> _authFormAbsent(FlutterDriver driver) async {
  await driver.waitForAbsent(find.byType('AuthForm'));
}
