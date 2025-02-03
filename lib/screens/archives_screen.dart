import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/event_provider.dart';
import '../models/event.dart';
import 'countdown_screen.dart';

class ArchivesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final archivedEvents =
        Provider.of<EventProvider>(context).archivedEvents;
    return Scaffold(
      appBar: AppBar(
        title: Text('Archived Events'),
      ),
      body: ListView.builder(
        itemCount: archivedEvents.length,
        itemBuilder: (context, index) {
          Event event = archivedEvents[index];
          return ListTile(
            title: Text(event.title),
            subtitle: Text(
                'Event Date: ${event.eventDate.toLocal().toString().split(" ")[0]}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CountdownScreen(event: event)),
              );
            },
          );
        },
      ),
    );
  }
}
