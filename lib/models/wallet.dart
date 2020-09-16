import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Wallet {
  static final String tableName = 'wallet';

  int id;
  String name;
  int value;

  Wallet({this.id, this.name, this.value});

  static Future<Database> getInstance() async {
    final String path = join( await getDatabasesPath(), '$tableName.db');
    final String sql = '''CREATE TABLE $tableName(
      id INTEGER PRIMARY KEY,
      name TEXT,
      value INTEGER
    )''';

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(sql);
    });
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'value': this.value
    };
  }
}