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
  int _lastTimeStamp = 0;
  void setLastTime(int time){
    _lastTimeStamp = time;
  }
  void start() async{
    final prefs = await SharedPreferences.getInstance();
    if(!kIsWeb)
    {
      _lastTimeStamp = prefs.getInt('lastTimestamp') ?? 0;
    }
    final query = _ref.orderByChild('timestamp').startAt(_lastTimeStamp + 1);
    query.onChildAdded.listen((DatabaseEvent event) async {
      final newEvent = Map<String, dynamic>.from(event.snapshot.value as Map);
      data.add(HistoryEntry(name: newEvent['name'], date: newEvent['date']));
      _lastTimeStamp = newEvent['timestamp'];
      if(!kIsWeb)
      {
        await prefs.setInt('lastTimestamp', _lastTimeStamp);
      }
      notifyListeners();
    });
  }
}