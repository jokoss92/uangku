import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Record {
  static final tableName = 'record';

  int id;
  String name;
  int value;
  int walletId;
  String type;

  Record({this.id, this.name, this.value, this.walletId, this.type});

  static Future<Database> getInstance() async {
    final String path = join( await getDatabasesPath(), '$tableName.db');
    final String sql = '''CREATE TABLE $tableName(
      id INTEGER PRIMARY KEY,
      name TEXT,
      value INTEGER,
      walletId INTEGER,
      type TEXT
    )''';

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(sql);
    });
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'value': this.value,
      'walletId': this.walletId,
      'type': this.type
    };
  }
}