import 'package:flutter_test/flutter_test.dart';
import 'package:microdonations/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('UserAvatarModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
