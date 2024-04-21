import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper({this.databaseName});
  final String quranTable = 'quran_id';
  final String suraCol = 'suraId';
  final String ayaCol = 'verseId';
  final String textCol = 'ayahText';

  final String? databaseName;

  Database? _database;

  Future<Database> get database async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, databaseName);

    // Ensure database exists before opening
    await copyDatabaseIfNotExist(path);

    _database ??= await openDatabase(path); // Open the database (null check)
    return _database!;
  }

  // Get all Quran verses for a specific sura
  Future<List<Map<String, dynamic>>> getVersesBySura(int sura) async {
    log('===================');
    log('$sura');
    log('===================');
    final db = await database;
    return db.query(
      quranTable,
      where: '$suraCol = ?',
      whereArgs: [sura],
    );
  }

  // Close the database connection
  Future<void> close() async {
    final db = await database;
    await db.close();
  }

  Future<void> copyDatabaseIfNotExist(String path) async {
    final dbExists = await databaseExists(path);
    if (!dbExists) {
      // If the database doesn't exist, copy it from the asset folder
      // await Future.delayed(const Duration(milliseconds: 500)); // Wait a bit (optional)
      final data = await rootBundle.load('assets/sources/$databaseName');
      final bytes = data.buffer.asUint8List();
      await File(path).writeAsBytes(bytes);
    }
  }
}
