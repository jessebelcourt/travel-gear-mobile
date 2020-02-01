import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './initial_migrations.dart';
import './migrations.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper.internal();

  static final String _databaseName = 'travel_gear.db';
  static final int _databaseVersion = 3;

  DatabaseHelper.internal() {

  }

  factory DatabaseHelper() => _databaseHelper;

  Future<Database> get database async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DatabaseHelper._databaseName);

    return await openDatabase(
      path,
      version: DatabaseHelper._databaseVersion,
      onOpen: _onOpen,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  void _onOpen(Database db) async {
    // Database is open, print its version
    print('db version ${await db.getVersion()}');
  }

  Future<void> _onCreate(Database db, int version) async {
    print('_onCreate fired. Running migrations for first time.');
    initialMigrations.forEach((migration) async => await db.execute(migration));
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('_onUpgrade fired. Running migrations');
    migrations.forEach((migration) async {
      if (migration['version'] == newVersion) { 
        await db.execute(migration['migration']);
      }
    });
    print('migrations have run');
  }
}
