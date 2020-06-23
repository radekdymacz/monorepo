import 'package:flutter/foundation.dart';
import 'package:metrics/common/presentation/models/project_model.dart';
import 'package:metrics/common/presentation/state/projects_notifier.dart';

/// Stub implementation of the [ProjectsNotifier].
///
/// Provides test implementation of the [ProjectsNotifier] methods.
class ProjectsNotifierStub extends ChangeNotifier implements ProjectsNotifier {
  final List<ProjectModel> _projectModels = [
    ProjectModel(id: '1', name: 'name1'),
    ProjectModel(id: '2', name: 'name2'),
  ];

  @override
  Future<void> subscribeToProjects() async {}

  @override
  String get projectsErrorMessage => null;

  @override
  Future<void> unsubscribeFromProjects() async {}

  @override
  List<ProjectModel> get projectModels => _projectModels;
}
