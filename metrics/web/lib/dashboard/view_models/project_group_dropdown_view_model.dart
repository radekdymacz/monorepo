/// Represents the data of the project group that using in project groups dropdown.
class ProjectGroupDropdownViewModel {
  final String id;
  final String name;
  final List<String> projectIds;

  /// Creates the [ProjectGroupDropdownViewModel]
  ///
  /// [id] is the unique identifier of the project group.
  /// [name] is the name of the project group.
  /// [projectIds] is the list of project ids related with
  /// the project group.
  ProjectGroupDropdownViewModel({
    this.id,
    this.name,
    this.projectIds,
  });
}
