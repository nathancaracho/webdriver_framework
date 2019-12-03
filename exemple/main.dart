import '../lib/webdriver.dart';

void main(List<String> args) async {
  var wf = Workflow(host: "http://localhost", port: 9515, stepList: [
    SearchGoogle("best rock band ever"),
    BestRockBand(),
  ]);
  await wf.init();
  wf.close();
}

class SearchGoogle implements Step {
  final String search;

  SearchGoogle(this.search);

  @override
  Future action(Webdriver webdriver, Map<String, dynamic> context) async {
    context["t"] = "t";
    await webdriver.navigateTo("http://www.google.com.br/");
    var el = await webdriver.findElement(By.name("q"));
    el.setValue(this.search);
    var form = await webdriver.findElement(By.name("f"));
    await form.submit();

    webdriver = null;
  }
}

class BestRockBand implements Step {
  @override
  Future action(Webdriver webdriver, Map<String, dynamic> context) async {
    print(context);
    var link = await webdriver.findElement(
        By.valueContains("The 50 best rock bands of all time | Louder"));
    link.click();
  }
}
