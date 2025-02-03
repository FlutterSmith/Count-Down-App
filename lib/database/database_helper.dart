import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/event.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('events.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT';
    const intType = 'INTEGER';

    await db.execute('''
      CREATE TABLE events (
        id $idType,
        title $textType NOT NULL,
        eventDate $textType NOT NULL,
        isArchived $intType NOT NULL,
        notificationDaysBefore $intType NOT NULL,
        colorHex $textType,
        emoji $textType,
        backgroundImagePath $textType
      )
    ''');
  }

  Future<int> insertEvent(Event event) async {
    final db = await instance.database;
    return await db.insert('events', event.toMap());
  }

  Future<List<Event>> getEvents() async {
    final db = await instance.database;
    final result = await db.query('events');
    return result.map((json) => Event.fromMap(json)).toList();
  }

  Future<int> updateEvent(Event event) async {
    final db = await instance.database;
    return await db.update(
      'events',
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<int> deleteEvent(int id) async {
    final db = await instance.database;
    return await db.delete(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
