class apiConvertClass {
  static int apiConvert(String text) {
    int convertTime;
    String temp = text.substring(11, 13);
    convertTime = int.parse(temp);
    print(convertTime);
    return convertTime;
  }
}
