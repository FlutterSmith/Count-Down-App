import 'package:flutter/material.dart';
import '../models/event.dart';
import '../database/database_helper.dart';

class EventProvider with ChangeNotifier {
  List<Event> _events = [];

  List<Event> get events =>
      _events.where((event) => !event.isArchived).toList();
  List<Event> get archivedEvents =>
      _events.where((event) => event.isArchived).toList();

  EventProvider() {
    loadEvents();
  }

  Future<void> loadEvents() async {
    _events = await DatabaseHelper.instance.getEvents();
    notifyListeners();
  }

  Future<void> addEvent(Event event) async {
    int id = await DatabaseHelper.instance.insertEvent(event);
    event.id = id;
    _events.add(event);
    notifyListeners();
  }

  Future<void> updateEvent(Event event) async {
    await DatabaseHelper.instance.updateEvent(event);
    int index = _events.indexWhere((e) => e.id == event.id);
    if (index != -1) {
      _events[index] = event;
      notifyListeners();
    }
  }
}
