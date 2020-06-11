import 'package:flutter/material.dart';
import 'package:metrics/common/presentation/metrics_theme/config/color_config.dart';
import 'package:metrics/common/presentation/metrics_theme/state/theme_notifier.dart';
import 'package:metrics/dashboard/presentation/state/project_metrics_notifier.dart';
import 'package:metrics/dashboard/view_models/project_group_dropdown_view_model.dart';
import 'package:provider/provider.dart';

class ProjectGroupsDropdown extends StatelessWidget {
  const ProjectGroupsDropdown({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Consumer<ProjectMetricsNotifier>(
      builder: (_, projectMetricsNotifier, __) {
        final viewModels =
            projectMetricsNotifier.projectGroupsDropdownViewModels;

        if (viewModels == null || viewModels.isEmpty) return Container();

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: themeNotifier.isDark
                  ? ColorConfig.darkInactiveColor
                  : ColorConfig.lightInactiveColor,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<ProjectGroupDropdownViewModel>(
              value: projectMetricsNotifier.projectGroupFilterViewModel,
              items: _generateDropdownMenuItems(viewModels),
              onChanged:
                  projectMetricsNotifier.changeProjectGroupFilterViewModel,
            ),
          ),
        );
      },
    );
  }

  /// Generates a list of [DropdownMenuItem] from the [ProjectGroupDropdownViewModel]s.
  List<DropdownMenuItem<ProjectGroupDropdownViewModel>>
      _generateDropdownMenuItems(
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
