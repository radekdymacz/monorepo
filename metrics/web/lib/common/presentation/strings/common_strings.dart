/// Holds the strings used across the whole project.
class CommonStrings {
  static const String home = 'Home';
  static const String lightTheme = 'Light theme';
  static const String projectGroups = 'Project groups';
  static const String users = 'Users';
  static const String navigateBack = 'Back';
  static const String openUserMenu = 'Open user menu';
  static const String metrics = 'metrics';
  static const String logOut = 'Logout';
  static const String searchForProject = 'Search for project...';
  static const String edit = 'Edit';
  static const String delete = 'Delete';
  static const String cancel = 'Cancel';
  static const String unknownErrorMessage =
      'An unknown error occurred, please try again';

  static String getLoadingErrorMessage(String errorMessage) =>
      'An error occurred during loading: $errorMessage';
}
