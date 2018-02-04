class StringUtils {

  static List<String> _dateWithLeadingZero(DateTime date) {
    String year = date.year.toString();
    String month = date.month.toString();
    String day = date.day.toString();

    if(month.length == 1)
      month = "0${month}";

    if(day.length == 1)
      day = "0${day}";

    List<String> dateList = [year, month, day];

    return dateList;
  }

  static String formatDateToApiFormat(DateTime date) {
    List<String> dateList = _dateWithLeadingZero(date);
    String currentDate = "${dateList[0]}-${dateList[1]}-${dateList[2]}";

    return currentDate;
  }

  static String formatDateBeautiful(DateTime date) {
    List<String> dateList = _dateWithLeadingZero(date);
    String beautifulDateString = "${dateList[2]}.${dateList[1]}.${dateList[0]}";

    return beautifulDateString;
  }

  static DateTime formatIndexToDate(int index) {
    DateTime forDay = new DateTime.now();
    forDay = forDay.add(new Duration(days: index));

    return forDay;
  }

  static String formatNumberToEuros(double number) {
    String numberAsString = number.toString();
    List<String> numbersSplitted = numberAsString.split(".");

    if(numbersSplitted[0].length <= 1) {
      numbersSplitted[0] = "0${numbersSplitted[0]}";
    }

    if(numbersSplitted[1].length <= 1) {
      numbersSplitted[1] = "${numbersSplitted[1]}0";
    }

    numberAsString = "${numbersSplitted[0]},${numbersSplitted[1]} €";

    return numberAsString;
  }
}