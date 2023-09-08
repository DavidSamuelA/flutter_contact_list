import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = 'Contact_List.db';
  static const _databaseVersion = 3;

  static const contactListTable = 'contact_list_table';

  static const columnId = '_id';
  static const columnName = '_name';
  static const columnMobileNo = '_mobileNo';
  static const columnEmailId = '_emailId';
  static const columnAddress = '_address';

  late Database _db;

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database database, int version) async {
    await database.execute('''
    CREATE TABLE $contactListTable(
    $columnId INTEGER PRIMARY KEY, 
    $columnName TEXT,
    $columnMobileNo TEXT,
    $columnEmailId TEXT,
    $columnAddress TEXT
    )
    ''');
  }

  _onUpgrade(Database database, int oldVersion, int newVersion) async {
    await database.execute('drop table $contactListTable');
    _onCreate(database, newVersion);
  }

  Future<int> insert(Map<String, dynamic> row, String tableName) async {
    return await _db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String tableName) async {
    return await _db.query(tableName);
  }

  Future<int> update(Map<String, dynamic> row, String tableName) async {
    int id = row[columnId];
    return await _db .update(tableName, row,
    where: '$columnId = ?', whereArgs: [id], );
  }

  Future<int> delete(int id, String tableName) async {
    return await _db.delete(tableName,
        where: '$columnId =?', whereArgs: [id], );
  }
}
