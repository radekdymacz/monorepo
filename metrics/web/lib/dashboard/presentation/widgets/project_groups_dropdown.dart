import 'package:flutter/material.dart';
import 'package:metrics/common/presentation/metrics_theme/config/color_config.dart';
import 'package:metrics/common/presentation/metrics_theme/state/theme_notifier.dart';
import 'package:metrics/common/presentation/widgets/metrics_dropdown_button.dart';
import 'package:metrics/dashboard/presentation/state/project_metrics_notifier.dart';
import 'package:metrics/dashboard/presentation/strings/dashboard_strings.dart';
import 'package:metrics/dashboard/view_models/project_group_dropdown_view_model.dart';
import 'package:provider/provider.dart';

/// Represents a dropdown button for project groups.
class ProjectGroupsDropdown extends StatelessWidget {
  const ProjectGroupsDropdown({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectMetricsNotifier>(
      builder: (_, notifier, __) {
        final themeNotifier = Provider.of<ThemeNotifier>(context);
        final viewModels = notifier.projectGroupsDropdownViewModels;
        final bool isDisabled = viewModels == null || viewModels.isEmpty;

        return MetricsDropdownButton<ProjectGroupDropdownViewModel>(
          value: notifier.projectGroupFilterViewModel,
          items: isDisabled ? null : _generateDropdownMenuItems(viewModels),
          onChanged:
              isDisabled ? null : notifier.changeProjectGroupFilterViewModel,
          disabledHint: Text(DashboardStrings.allProjectGroups),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: themeNotifier.isDark
                  ? ColorConfig.darkInactiveColor
                  : ColorConfig.lightInactiveColor,
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
