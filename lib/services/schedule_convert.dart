class apiConvertClass {
  static int apiConvert(String text) {
    int convertTime = 0;
    if (text.length == 0) {
      return convertTime;
    }
    String temp = text.substring(11, 13);
    convertTime = int.parse(temp);
    return convertTime;
  }

  static int apiConvertUpdate(String text) {
    int convertTime;
    String temp = "";
    if (text.substring(11, 11) == '0') {
      temp = text.substring(12, 13);
    } else {
      temp = text.substring(11, 13);
    }
    convertTime = int.parse(temp);
    return convertTime;
  }
}
