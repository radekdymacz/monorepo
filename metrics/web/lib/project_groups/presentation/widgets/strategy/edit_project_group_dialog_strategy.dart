import 'package:metrics/project_groups/presentation/state/project_groups_notifier.dart';
import 'package:metrics/project_groups/presentation/strings/project_groups_strings.dart';
import 'package:metrics/project_groups/presentation/widgets/edit_project_group_dialog.dart';
import 'package:metrics/project_groups/presentation/widgets/strategy/project_group_dialog_strategy.dart';

/// The [ProjectGroupDialogStrategy] implementation for the
/// [EditProjectGroupDialog] and editing a project group.
class EditProjectGroupDialogStrategy implements ProjectGroupDialogStrategy {
  @override
  final String title = ProjectGroupsStrings.editProjectGroup;

  @override
  final String text = ProjectGroupsStrings.saveChanges;

  @override
  final String loadingText = ProjectGroupsStrings.savingProjectGroup;

  @override
  Future<void> action(
    ProjectGroupsNotifier notifier,
    String groupId,
    String groupName,
    List<String> projectIds,
  ) {
    return notifier.updateProjectGroup(groupId, groupName, projectIds);
  }
}
