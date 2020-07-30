import 'package:flutter/material.dart';
import 'package:metrics/common/presentation/dropdown/widgets/metrics_dropdown_menu.dart';
import 'package:metrics/common/presentation/metrics_theme/widgets/metrics_theme.dart';
import 'package:metrics/dashboard/presentation/state/project_metrics_notifier.dart';
import 'package:metrics/dashboard/presentation/view_models/project_group_dropdown_item_view_model.dart';
import 'package:metrics/dashboard/presentation/widgets/project_groups_dropdown_item.dart';
import 'package:provider/provider.dart';

/// A dropdown menu widget providing an ability to select a project group.
class ProjectGroupsDropdownMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = MetricsTheme.of(context).dropdownTheme;

    return Consumer<ProjectMetricsNotifier>(
      builder: (_, notifier, __) {
        return MetricsDropdownMenu<ProjectGroupDropdownItemViewModel>(
          items: notifier.projectGroupDropdownItems,
          onItemSelected: (item) {
            notifier.selectProjectGroup(item.id);
          },
          itemBuilder: (_, item) {
            return ProjectGroupsDropdownItem(
              projectGroupDropdownItemViewModel: item,
            );
          },
          selectedItemBuilder: (_, __) => Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    notifier.selectedProjectGroup?.name ?? "",
                    style: theme.textStyle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 13.0,
                  horizontal: 10.0,
                ),
                child: Image.network(
                  "icons/dropdown.svg",
                  height: 20.0,
                  width: 20.0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
