import 'package:webdriver_framework/src/work_flow/step.dart';
import 'package:webdriver_framework/src/core/core.dart';

class Workflow {
  final List<Step> stepList;
  final int port;
  final String host;
  Map<String, dynamic> _context = {};
  Webdriver _webdriver;
  Workflow({this.host, this.port, this.stepList});

  Future init() async {
    this._webdriver = await webdriverFactory(host: this.host, port: this.port);

    for (Step step in stepList)
      await step.action(this._webdriver, this._context);
  }

  Future close() async {
    await this._webdriver.close();
  }
}
