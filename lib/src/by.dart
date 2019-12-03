class By {
  final String using;
  final String value;

  By.name(this.value) : using = "name";
  By.id(this.value) : using = "id";
  By.css(this.value) : using = "css";
  By.xpath(this.value) : using = "xpath";
  By.valueContains(String value)
      : value = "//*[contains(text(),'$value')]",
        using = "xpath";
  By.value(String value)
      : value = "//*[text() = '$value']",
        using = "xpath";
}
