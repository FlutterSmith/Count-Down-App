import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/event_provider.dart';
import 'add_event_screen.dart';
import 'countdown_screen.dart';
import 'archives_screen.dart';
import '../models/event.dart';

class EventListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Active Countdown Events'),
        actions: [
          IconButton(
            icon: Icon(Icons.archive),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ArchivesScreen()));
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await eventProvider.loadEvents();
        },
        child: ListView.builder(
          itemCount: eventProvider.events.length,
          itemBuilder: (context, index) {
            Event event = eventProvider.events[index];
            return ListTile(
              leading: event.emoji != null
                  ? Text(event.emoji!, style: TextStyle(fontSize: 24))
                  : null,
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddEventScreen()));
        },
      ),
    );
  }
}
