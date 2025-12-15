class HistoryEntry {
  int year;
  int month;
  int day;
  int hour;
  int minute;
  String name;

  HistoryEntry({
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.name,
  });
  @override
  String toString() {
    int actualHour = hour % 12;
    if (actualHour == 0) actualHour = 12;
    String amPm = hour >= 12 ? "PM" : "AM";
    return "$year-$month-$day $actualHour:$minute $amPm";
  }
}
