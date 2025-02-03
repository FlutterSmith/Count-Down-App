import 'dart:io';
import 'package:countdown_app/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/event.dart';
import '../providers/event_provider.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int _notificationDaysBefore = 1;
  String? _colorHex;
  String? _emoji;
  File? _backgroundImage;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null)
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null)
      setState(() {
        _selectedTime = picked;
      });
  }

  Future<void> _pickBackgroundImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _backgroundImage = File(pickedFile.path);
      });
    }
  }

  void _saveEvent() async {
    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _selectedTime != null) {
      DateTime eventDate = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );
      Event newEvent = Event(
        title: _titleController.text,
        eventDate: eventDate,
        notificationDaysBefore: _notificationDaysBefore,
        colorHex: _colorHex,
        emoji: _emoji,
        backgroundImagePath: _backgroundImage?.path,
      );
      await Provider.of<EventProvider>(context, listen: false)
          .addEvent(newEvent);
      await NotificationService().scheduleNotification(newEvent);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Countdown Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Event Name
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Event Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter an event name' : null,
              ),
              SizedBox(height: 16),
              // Date picker
              ListTile(
                title: Text(_selectedDate == null
                    ? 'Select Date'
                    : _selectedDate!.toLocal().toString().split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              // Time picker
              ListTile(
                title: Text(_selectedTime == null
                    ? 'Select Time'
                    : _selectedTime!.format(context)),
                trailing: Icon(Icons.access_time),
                onTap: _pickTime,
              ),
              // Notification days before event
              TextFormField(
                initialValue: '1',
                decoration:
                    InputDecoration(labelText: 'Notify days before event'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _notificationDaysBefore = int.tryParse(value) ?? 1;
                },
              ),
              SizedBox(height: 16),
              // Emoji (optional)
              TextFormField(
                decoration: InputDecoration(labelText: 'Emoji (optional)'),
                onChanged: (value) {
                  _emoji = value;
                },
              ),
              SizedBox(height: 16),
              // Color (optional)
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Color (Hex, e.g., #FF5733) optional'),
                onChanged: (value) {
                  _colorHex = value;
                },
              ),
              SizedBox(height: 16),
              // Background image picker
              ElevatedButton(
                onPressed: _pickBackgroundImage,
                child: Text('Pick Background Image'),
              ),
              if (_backgroundImage != null)
                Image.file(_backgroundImage!, height: 100, width: 100),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveEvent,
                child: Text('Save Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
