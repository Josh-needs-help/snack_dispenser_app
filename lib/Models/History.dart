import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snack_dispenser_app/Models/HistoryEntry.dart';

class History extends ChangeNotifier {
  History._();
  static final History instance = History._();
  final List<HistoryEntry> data = [];
  List<int> weeklyActivity = List.filled(4, 0);
  List<int> monthlyActivity = List.filled(4, 0);
  List<int> yearlyActivity = List.filled(4, 0);
  final _ref = FirebaseDatabase.instance.ref('history');
  int weeklyCount = 0;
  int monthlyCount = 0;
  int yearlyCount = 0;
  int _lastTimeStamp = 0;
  void setLastTime(int time) {
    _lastTimeStamp = time;
  }

  void start() async {
    final prefs = await SharedPreferences.getInstance();
    if (!kIsWeb) {
      _lastTimeStamp = prefs.getInt('lastTimestamp') ?? 0;
    }
    final query = _ref.orderByChild('timestamp').startAt(_lastTimeStamp + 1);
    query.onChildAdded.listen((DatabaseEvent event) async {
      final newEvent = Map<String, dynamic>.from(event.snapshot.value as Map);
      data.add(HistoryEntry(name: newEvent['name'], date: newEvent['date']));
      _lastTimeStamp = newEvent['timestamp'];
      if (!kIsWeb) {
        await prefs.setInt('lastTimestamp', _lastTimeStamp);
      }
      notifyListeners();
    });
  }

  List<int> getWeekdayCount() {
    weeklyCount = 0;
    weeklyActivity = List.filled(4, 0);
    final now = DateTime.now();
    final startOfWeek = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(Duration(days: 6));

    final count = List.filled(7, 0);

    for (final entry in data) {
      final entryDate = entry.dateToDateTime();
      final entryDateOnly = DateTime(
        entryDate.year,
        entryDate.month,
        entryDate.day,
      );
      final startOfWeekOnly = DateTime(
        startOfWeek.year,
        startOfWeek.month,
        startOfWeek.day,
      );
      final endOfWeekOnly = DateTime(
        endOfWeek.year,
        endOfWeek.month,
        endOfWeek.day,
      );
      if (!entryDateOnly.isBefore(startOfWeekOnly) &&
          !entryDateOnly.isAfter(endOfWeekOnly)) {
        _catagorizeHour(entryDate,weeklyActivity);
        count[entryDateOnly.weekday - 1]++;
      }
    }
    for (int i in count) {
      weeklyCount += i;
    }
    return count;
  }

  List<int> getMonthlyCount() {
    monthlyCount = 0;
    monthlyActivity = List.filled(4, 0);
    DateTime now = DateTime.now();
    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    List<int> count = List.generate(daysInMonth, (index) => 0);
    for (int i = 0; i < data.length; i++) {
      if (data[i].getMonth() == now.month && data[i].getYear() == now.year) {
        _catagorizeHour(data[i].dateToDateTime(),monthlyActivity);
        count[data[i].getDay() - 1]++;
      }
    }
    for (int i in count) {
      monthlyCount += i;
    }
    return count;
  }

  List<int> getYearlyCount() {
    yearlyCount = 0;
    yearlyActivity = List.filled(4, 0);
    DateTime now = DateTime.now();
    List<int> count = List.generate(12, (index) => 0);
    for (int i = 0; i < data.length; i++) {
      if (data[i].getYear() == now.year) {
        _catagorizeHour(data[i].dateToDateTime(),yearlyActivity);
        count[data[i].getMonth() - 1]++;
      }
    }
    for (int i in count) {
      yearlyCount += i;
    }
    return count;
  }

  bool isLeapYear(int year) {
    return (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
  }
  int calculateTodayUsage()
  {
    int count = 0;
     DateTime now = DateTime.now();
     for(HistoryEntry i in data)
     {
      if(i.dateToDateTime().day==now.day)
      {
        count++;
      }
     }
     return count;
  }
  List<HistoryEntry> getLastEntries() {
    List<HistoryEntry> entries = [];
    for (int i = 0; i < 10; i++) {
      if (data.length - i - 1 < 0) return entries;
      entries.add(data[data.length - i - 1]);
    }
    return entries;
  }

  void _catagorizeHour(DateTime entryDate,List<int> list) {
    final hour = entryDate.hour;
    if (hour >= 6 && hour < 12) {
      list[0]++;
    } else if (hour >= 12 && hour < 18) {
      list[1]++;
    } else if (hour >= 18) {
      list[2]++;
    } else {
      list[3]++;
    }
  }
}
