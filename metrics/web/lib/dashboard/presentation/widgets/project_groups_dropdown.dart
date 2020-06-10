import 'package:flutter/material.dart';
import 'package:metrics/dashboard/presentation/state/project_metrics_notifier.dart';
import 'package:metrics/dashboard/view_models/project_group_dropdown_view_model.dart';
import 'package:provider/provider.dart';

class ProjectGroupsDropdown extends StatelessWidget {
  const ProjectGroupsDropdown({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectMetricsNotifier>(
      builder: (_, projectMetricsNotifier, __) {
        final viewModels = projectMetricsNotifier.projectGroupsDropdownViewModels;
        
        if (viewModels == null || viewModels.isEmpty) return Container();

        return DropdownButton<ProjectGroupDropdownViewModel>(
          value: projectMetricsNotifier.projectGroupFilterViewModel,
          items: _generateDropdownMenuItems(viewModels),
          onChanged: projectMetricsNotifier.changeCurrentViewModelFilter,
        );
      },
    );
  }

  /// Generates a list of [DropdownMenuItem] from the [ProjectGroupDropdownViewModel]s.
  List<DropdownMenuItem<ProjectGroupDropdownViewModel>> _generateDropdownMenuItems(
    List<ProjectGroupDropdownViewModel> viewModels,
  ) {
    return viewModels.map<DropdownMenuItem<ProjectGroupDropdownViewModel>>(
      (ProjectGroupDropdownViewModel viewModel) {
        return DropdownMenuItem<ProjectGroupDropdownViewModel>(
          value: viewModel,
          child: Text(viewModel.name),
        );
      },
    ).toList();
  }
}