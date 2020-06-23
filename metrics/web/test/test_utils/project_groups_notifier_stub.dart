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
  final _projectCheckboxViewModels = [
    ProjectCheckboxViewModel(id: '1', name: 'name1', isChecked: false),
    ProjectCheckboxViewModel(id: '2', name: 'name2', isChecked: false),
  ];

  final _projectGroupCardViewModels = [
    ProjectGroupCardViewModel(id: '1', name: 'name1', projectsCount: 1),
    ProjectGroupCardViewModel(id: '2', name: 'name2', projectsCount: 2),
  ];

  final _projectGroupDialogViewModel = ProjectGroupDialogViewModel(
    id: '1',
    name: 'name1',
    selectedProjectIds: [],
  );

  final _projectGroupDeleteDialogViewModel = ProjectGroupDeleteDialogViewModel(
    id: '1',
    name: 'name1',
  );

  @override
  Future<void> addProjectGroup(
      String projectGroupId, String projectGroupName, List<String> projectIds) {
    // TODO: implement addProjectGroup
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProjectGroup(String projectGroupId) {
    // TODO: implement deleteProjectGroup
    throw UnimplementedError();
  }

  @override
  void filterByProjectName(String value) {
    // TODO: implement filterByProjectName
  }

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
  // TODO: implement projectGroupSavingError
  ProjectGroupFirestoreErrorMessage get projectGroupSavingError =>
      throw UnimplementedError();

  @override
  // TODO: implement projectGroups
  List<ProjectGroup> get projectGroups => throw UnimplementedError();

  @override
  String get projectGroupsErrorMessage => null;

  @override
  String get projectsErrorMessage => null;

  @override
  void resetFilterName() {
    // TODO: implement resetFilterName
  }

  @override
  void resetProjectGroupSavingErrorMessage() {
    // TODO: implement resetProjectGroupSavingErrorMessage
  }

  @override
  void setProjectGroupDeleteDialogViewModel(String projectGroupId) {
    // TODO: implement setProjectGroupDeleteDialogViewModel
  }

  @override
  void setProjectGroupDialogViewModel([String projectGroupId]) {
    // TODO: implement setProjectGroupDialogViewModel
  }

  @override
  Future<void> subscribeToProjectGroups() async {}

  @override
  void toggleProjectCheckedStatus({String projectId, bool isChecked}) {
    // TODO: implement toggleProjectCheckedStatus
  }

  @override
  Future<void> unsubscribeFromProjectGroups() {
    // TODO: implement unsubscribeFromProjectGroups
    throw UnimplementedError();
  }

  @override
  Future<void> updateProjectGroup(
      String projectGroupId, String projectGroupName, List<String> projectIds) {
    // TODO: implement updateProjectGroup
    throw UnimplementedError();
  }

  @override
  void updateProjects(
      List<ProjectModel> projects, String projectsErrorMessage) {
    // TODO: implement updateProjects
  }
}
