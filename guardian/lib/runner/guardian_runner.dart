import 'package:args/command_runner.dart';
import 'package:guardian/jira/runner/jira_runner.dart';
import 'package:guardian/runner/options/global_options.dart';
import 'package:guardian/slack/runner/slack_runner.dart';

class GuardianRunner extends CommandRunner {
  GuardianRunner() : super('guardian', 'Guardian CLI') {
    addCommand(SlackRunner());
    addCommand(JiraRunner());

    argParser.addFlag(
      'stack-trace',
      help: 'Prints stack trace for errors catched',
      callback: (value) {
        GlobalOptions().enableStackTrace = value;
      },
    );
  }
}
