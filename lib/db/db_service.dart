import 'package:fish_prawn_crab/db/db_schema.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static const _dbPath = "database.db";
  static Database? _database;
  static final instance = DatabaseService._();

  DatabaseService._();

  Database? get database {
    return _database;
  }

  Future<void> initDatabase() async {
    _database = await openDatabase(
      _dbPath,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    // Create the round table
    await db.execute('''
      CREATE TABLE ${DatabaseSchema.tableRound.name} (
        ${_generateFields(DatabaseSchema.tableRound.fields)}
      )
    ''');

    // Create the round_log table
    await db.execute('''
      CREATE TABLE ${DatabaseSchema.tableRoundLog.name} (
        ${_generateFields(DatabaseSchema.tableRoundLog.fields)}
      )
    ''');
  }

  String _generateFields(Map<String, String> fields) {
    return fields.entries
        .map((entry) => '${entry.key} ${entry.value}')
        .join(', ');
  }
}
