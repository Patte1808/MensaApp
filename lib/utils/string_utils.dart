class StringUtils {

  static String formatDateToApiFormat(DateTime date) {
    String year = date.year.toString();
    String month = date.month.toString();
    String day = date.day.toString();

    if(month.length == 1)
      month = "0${month}";

    if(day.length == 1)
      day = "0${day}";

    String currentDate = "${year}-${month}-${day}";

    return currentDate;
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