import 'package:webdriver_framework/src/core/core.dart';

abstract class Step {
  Future action(Webdriver webdriver, Map<String, dynamic> context);
}
