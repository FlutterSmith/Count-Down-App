import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:provider/provider.dart';
import '../models/event.dart';
import '../providers/event_provider.dart';

class HomeWidgetHandler {
  /// Update widget with the first active event's title and days left.
  static Future<void> updateWidget(BuildContext context) async {
    final events = Provider.of<EventProvider>(context, listen: false).events;
    if (events.isNotEmpty) {
      Event event = events.first;
      final now = DateTime.now();
      final daysLeft = event.eventDate.difference(now).inDays;
      await HomeWidget.saveWidgetData<String>('eventTitle', event.title);
      await HomeWidget.saveWidgetData<int>('daysLeft', daysLeft);
    }
    await HomeWidget.updateWidget(
      name: 'HomeScreenWidgetProvider',
      iOSName: 'HomeScreenWidget',
    );
  }
}
