import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:metrics/project_groups/presentation/widgets/strategy/edit_project_group_dialog_strategy.dart';
import 'package:metrics/project_groups/presentation/strings/project_groups_strings.dart';

import '../../../../test_utils/project_groups_notifier_mock.dart';

void main() {
  group("EditProjectGroupDialogStrategy", () {
    final strategy = EditProjectGroupDialogStrategy();

    test(
      ".loadingText equals to ProjectGroupsStrings.savingProjectGroup",
      () {
        expect(
          strategy.loadingText,
          equals(ProjectGroupsStrings.savingProjectGroup),
        );
      },
    );

    test(".text equals to ProjectGroupString.saveChanges", () {
      expect(
        strategy.text,
        equals(ProjectGroupsStrings.saveChanges),
      );
    });

    test(".title equals to ProjectGroupString.editProjectGroup", () {
      expect(
        strategy.title,
        equals(ProjectGroupsStrings.editProjectGroup),
      );
    });

    test(
      ".action() delegates updating a project group to the given notifier",
      () {
        const id = 'groupId';
        const name = 'groupName';
        const projectIds = <String>[];
        final notifier = ProjectGroupsNotifierMock();

        strategy.action(notifier, id, name, projectIds);

        verify(
          notifier.updateProjectGroup(id, name, projectIds),
        ).called(equals(1));
      },
    );
  });
}
