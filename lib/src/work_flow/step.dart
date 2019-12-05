import 'package:webdriver_framework/src/driver/driver.dart';

abstract class Step {
  Future action(Webdriver webdriver, Map<String, dynamic> context);
}
