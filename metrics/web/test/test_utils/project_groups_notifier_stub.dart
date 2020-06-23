import 'package:flutter/foundation.dart';
import 'package:metrics/common/presentation/models/project_model.dart';
import 'package:metrics/project_groups/domain/entities/project_group.dart';
import 'package:metrics/project_groups/presentation/models/project_group_firestore_error_message.dart';
import 'package:metrics/project_groups/presentation/state/project_groups_notifier.dart';
import 'package:metrics/project_groups/presentation/view_models/project_checkbox_view_model.dart';
import 'package:metrics/project_groups/presentation/view_models/project_group_card_view_model.dart';
import 'package:metrics/project_groups/presentation/view_models/project_group_delete_dialog_view_model.dart';
import 'package:metrics/project_groups/presentation/view_models/project_group_dialog_view_model.dart';

/// Stub implementation of the [ProjectGroupsNotifier].
///
/// Provides test implementation of the [ProjectGroupsNotifier] methods.
class ProjectGroupsNotifierStub extends ChangeNotifier
    implements ProjectGroupsNotifier {
  /// A test [ProjectCheckboxViewModel]s used in tests.
  static const _projectCheckboxViewModels = [
    ProjectCheckboxViewModel(id: '1', name: 'name1', isChecked: false),
    ProjectCheckboxViewModel(id: '2', name: 'name2', isChecked: false),
  ];

  /// A test [ProjectGroupCardViewModel]s used in tests.
  static const _projectGroupCardViewModels = [
    ProjectGroupCardViewModel(id: '1', name: 'name1', projectsCount: 1),
    ProjectGroupCardViewModel(id: '2', name: 'name2', projectsCount: 2),
  ];

  /// A test [ProjectGroupDialogViewModel] used in tests.
  final _projectGroupDialogViewModel = ProjectGroupDialogViewModel(
    id: '1',
    name: 'name1',
    selectedProjectIds: [],
  );

  /// A test [ProjectGroupDeleteDialogViewModel] used in tests.
  final _projectGroupDeleteDialogViewModel = ProjectGroupDeleteDialogViewModel(
    id: '1',
    name: 'name1',
  );

  @override
  Future<void> addProjectGroup(
    String projectGroupId,
    String projectGroupName,
    List<String> projectIds,
  ) async {}

  @override
  Future<void> deleteProjectGroup(String projectGroupId) async {}

  @override
  void filterByProjectName(String value) {}

  @override
  List<ProjectCheckboxViewModel> get projectCheckboxViewModels =>
      _projectCheckboxViewModels;

  @override
  List<ProjectGroupCardViewModel> get projectGroupCardViewModels =>
      _projectGroupCardViewModels;

  @override
  ProjectGroupDeleteDialogViewModel get projectGroupDeleteDialogViewModel =>
      _projectGroupDeleteDialogViewModel;

  @override
  ProjectGroupDialogViewModel get projectGroupDialogViewModel =>
      _projectGroupDialogViewModel;

  @override
  ProjectGroupFirestoreErrorMessage get projectGroupSavingError => null;

  @override
  List<ProjectGroup> get projectGroups => null;

  @override
  String get projectGroupsErrorMessage => null;

  @override
  String get projectsErrorMessage => null;

  @override
  void resetFilterName() {}

  @override
  void resetProjectGroupSavingErrorMessage() {}

  @override
  void setProjectGroupDeleteDialogViewModel(String projectGroupId) {}

  @override
  void setProjectGroupDialogViewModel([String projectGroupId]) {}

  @override
  Future<void> subscribeToProjectGroups() async {}

  @override
  void toggleProjectCheckedStatus({String projectId, bool isChecked}) {}

  @override
  Future<void> unsubscribeFromProjectGroups() async {}

  @override
  Future<void> updateProjectGroup(
    String projectGroupId,
    String projectGroupName,
    List<String> projectIds,
  ) async {}

  @override
  void updateProjects(
    List<ProjectModel> projects,
    String projectsErrorMessage,
  ) {}
}
