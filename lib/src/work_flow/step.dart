import 'package:webdriver_framework/src/webdriver.dart';

abstract class Step {
  Future action(Webdriver webdriver, Map<String, dynamic> context);
}
