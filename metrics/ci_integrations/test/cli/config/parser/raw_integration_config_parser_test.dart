import 'package:ci_integration/cli/config/parser/raw_integration_config_parser.dart';
import 'package:test/test.dart';

// ignore_for_file: prefer_const_constructors

void main() {
  group("RawIntegrationConfigParser", () {
    final configParser = RawIntegrationConfigParser();

    const sourceProjectId = 'sourceProjectId';
    const sourceConfig = "source:\n"
        " test_source:\n"
        "   source_project_id: $sourceProjectId\n";
    const sourceConfigMap = {
      'test_source': {
        'source_project_id': sourceProjectId,
      },
    };
    const destinationProjectId = 'destinationProjectId';
    const destinationConfig = "destination:\n"
        " test_destination:\n"
        "   destination_project_id: $destinationProjectId\n";
    const destinationConfigMap = {
      'test_destination': {
        'destination_project_id': destinationProjectId,
      },
    };

    test(
      ".parse() should throw an ArgumentError if the given configYaml is null",
      () {
        expect(() => configParser.parse(null), throwsArgumentError);
      },
    );

    test(
      ".parse() should throw a FormatException if the source config is missing",
      () {
        expect(
          () => configParser.parse(destinationConfig),
          throwsFormatException,
        );
      },
    );

    test(
      ".parse() should throw a FormatException if the destination config is missing",
      () {
        expect(() => configParser.parse(sourceConfig), throwsFormatException);
      },
    );

    test(
      ".parse() should create RawIntegrationConfig from the given config yaml string",
      () {
        final config = configParser.parse('$sourceConfig$destinationConfig');

        expect(config.sourceConfigMap, sourceConfigMap);
        expect(config.destinationConfigMap, destinationConfigMap);
      },
    );
  });
}
