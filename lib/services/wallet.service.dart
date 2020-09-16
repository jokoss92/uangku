import 'package:uangku_/models/wallet.dart';
import 'package:sqflite/sqflite.dart';

class WalletService {
  final String _tableName = Wallet.tableName;

  Future<int> insert(Wallet wallet) async {
    final Database db = await Wallet.getInstance();

    return await db.insert(_tableName, wallet.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Wallet>> getLists() async {
    final Database db = await Wallet.getInstance();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return Wallet(
          id: maps[i]['id'], name: maps[i]['name'], value: maps[i]['value']);
    });
  }
}
