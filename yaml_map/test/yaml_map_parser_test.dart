// https://github.com/software-platform/monorepo/issues/140
// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:yaml_map/yaml_map.dart';

void main() {
  group('YamlMapParser', () {
    final parser = YamlMapParser();

    test('parse() should throw ArgumentError if input is not dictionary', () {
      const yamlString = '1';

      expect(() => parser.parse(yamlString), throwsArgumentError);
    });

    test('parse() should throw ArgumentError if input is null', () {
      expect(() => parser.parse(null), throwsArgumentError);
    });

    test('parse() should return empty map on empty input', () {
      const yamlString = '';
      final result = parser.parse(yamlString);

      expect(result, isEmpty);
    });

    test('parse() should throw FormatException if input has complex keys', () {
      const yamlString = '{1, 2}: 3';

      expect(() => parser.parse(yamlString), throwsFormatException);
    });

    test('parse() should parse nested YAML dictionaries', () {
      // Formatted yaml string
      // f1:
      //   f2: 1
      //   f3: 2
      const yamlString = 'f1:\n  f2: 1\n  f3: 2';
      final result = parser.parse(yamlString);

      expect(
        result,
        equals({
          'f1': {
            'f2': 1,
            'f3': 2,
          }
        }),
      );
    });

    test('parse() should parse YAML lists', () {
      // Formatted yaml string
      // list:
      //   - 1
      //   - 2
      const yamlString = 'list:\n  - 1\n  - 2';
      final result = parser.parse(yamlString);

      expect(
        result,
        equals({
          'list': [1, 2]
        }),
      );
    });

    test('parse() should parse YAML strings', () {
      // Formatted yaml string
      // string: 'value'
      const yamlString = "string: 'value'";
      final result = parser.parse(yamlString);

      expect(result, equals({'string': 'value'}));
    });

    test('parse() should parse YAML nums', () {
      // Formatted yaml string
      // int: 1
      // double: 1.0
      const yamlString = 'int: 1\ndouble: 1.0';
      final result = parser.parse(yamlString);

      expect(result, equals({'int': 1, 'double': 1.0}));
    });
  });
}
