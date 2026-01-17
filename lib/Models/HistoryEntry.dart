

class HistoryEntry {
  String date;
  String name;

  HistoryEntry({required this.name, required this.date});
  @override
  String toString() {
    List<String> dateSplit = date.split(",");
    int year = int.parse(dateSplit[0]);
    int month = int.parse(dateSplit[1]);
    int day = int.parse(dateSplit[2]);
    int hour = int.parse(dateSplit[3]);
    int minute = int.parse(dateSplit[4]);
    int actualHour = hour % 12;
    if (actualHour == 0) actualHour = 12;
    String amPm = hour >= 12 ? "PM" : "AM";
    return "$year-$month-$day $actualHour:$minute $amPm";
  }

  int getWeekday() {
    int weekday = dateToDateTime().weekday;
    return weekday;
  }

  int getDay() {
    return dateToDateTime().day;
  }

  int getMonth() {
    return dateToDateTime().month;
  }

  int getYear() {
    return dateToDateTime().year;
  }

  DateTime dateToDateTime() {
    List<String> dateSplit = date.split(",");
    int year = int.parse(dateSplit[0]);
    int month = int.parse(dateSplit[1]);
    int day = int.parse(dateSplit[2]);
    int hour = int.parse(dateSplit[3]);
    int minute = int.parse(dateSplit[4]);
    return DateTime(year, month, day, hour, minute);
  }
}
