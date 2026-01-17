import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snack_dispenser_app/Models/HistoryEntry.dart';

class History extends ChangeNotifier {
  History._();
  static final History instance = History._();
  final List<HistoryEntry> data = [];
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
        count[entryDateOnly.weekday - 1]++;
      }
    }
    for (int i in count) {
      weeklyCount += i;
    }
    return count;
  }

  List<int> getMonthlyCount() {
    DateTime now = DateTime.now();
    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    List<int> count = List.generate(daysInMonth, (index) => 0);
    for (int i = 0; i < data.length; i++) {
      if (data[i].getMonth() == now.month && data[i].getYear() == now.year) {
        count[data[i].getDay() - 1]++;
      }
    }
    for (int i in count) {
      monthlyCount += i;
    }
    return count;
  }

  List<int> getYearlyCount() {
    DateTime now = DateTime.now();
    List<int> count = List.generate(12, (index) => 0);
    for (int i = 0; i < data.length; i++) {
      if (data[i].getYear() == now.year) {
        count[data[i].getMonth() - 1]++;
      }
      for (int i in count) {
        yearlyCount += i;
      }
    }
    return count;
  }

  bool isLeapYear(int year) {
    return (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
  }

  List<HistoryEntry> getLastEntries() {
    List<HistoryEntry> entries = [];
    for (int i = 0; i < 10; i++) {
      if (data.length - i - 1 < 0) return entries;
      entries.add(data[data.length - i - 1]);
    }
    return entries;
  }
}
