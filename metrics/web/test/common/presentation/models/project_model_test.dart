import 'package:metrics/common/presentation/models/project_model.dart';
import 'package:test/test.dart';

import '../../../test_utils/matcher_util.dart';

// ignore_for_file: prefer_const_constructors

void main() {
  group("ProjectModel", () {
    const id = 'id';
    const name = 'name';

    test("throws an AssertionError if the given id is null", () {
      expect(
        () => ProjectModel(id: null, name: name),
        MatcherUtil.throwsAssertionError,
      );
    });

    test("throws an AssertionError if the given name is null", () {
      expect(
        () => ProjectModel(id: id, name: null),
        MatcherUtil.throwsAssertionError,
      );
    });

    test("successfully creates an instance on a valid input", () {
      expect(() => ProjectModel(id: id, name: name), returnsNormally);
    });
  });
}
