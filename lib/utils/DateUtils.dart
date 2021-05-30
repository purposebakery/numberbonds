class DateUtils {
  static String getFormatted(DateTime datetime) {
    return "${datetime.day}-${datetime.month}-${datetime.year}";
  }
}
