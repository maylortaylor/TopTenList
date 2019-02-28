import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toptenlist/models/List.dart';

class AppListsDatabase {
  static final AppListsDatabase _listsDatabase =
      new AppListsDatabase._internal();

  final String tableName = "AppLists";

  Database db;

  bool didInit = false;

  static AppListsDatabase get() {
    return _listsDatabase;
  }

  AppListsDatabase._internal();

  /// Use this method to access the database, because initialization of the database (it has to go through the method channel)
  Future<Database> _getDb() async {
    if (!didInit) await _init();
    return db;
  }

  Future init() async {
    return await _init();
  }

  Future _init() async {
    // Get a location using path_provider
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "demo.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute("CREATE TABLE $tableName ("
          "${AppListItem.db_id} STRING PRIMARY KEY,"
          "${AppListItem.db_title} TEXT,"
          "${AppListItem.db_url} TEXT,"
          "${AppListItem.db_star} BIT,"
          "${AppListItem.db_creator} TEXT,"
          "${AppListItem.db_description} TEXT,"
          ")");
    });
    didInit = true;
  }

  Future<int> createAppList(AppListItem appListItem) async {
    var db = await _getDb();
    int resultId = await db.rawInsert(
        'INSERT INTO $tableName(${AppListItem.db_title}, ${AppListItem.db_description}, ${AppListItem.db_url}, ${AppListItem.db_star}, ${AppListItem.db_creator} )');
    if (resultId >= 0) return null;
    return resultId;
  }

  /// Get a book by its id, if there is not entry for that ID, returns null.
  Future<AppListItem> getAppList(String id) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM $tableName WHERE ${AppListItem.db_id} = "$id"');
    if (result.length == 0) return null;
    return new AppListItem.fromMap(result[0]);
  }

  /// Get all books with ids, will return a list with all the books found
  Future<List<AppListItem>> getAppLists(List<String> ids) async {
    var db = await _getDb();
    // Building SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)
    var idsString = ids.map((it) => '"$it"').join(',');
    var result = await db.rawQuery(
        'SELECT * FROM $tableName WHERE ${AppListItem.db_id} IN ($idsString)');
    List<AppListItem> appLists = [];
    for (Map<String, dynamic> item in result) {
      appLists.add(new AppListItem.fromMap(item));
    }
    return appLists;
  }

  Future<List<AppListItem>> getFavoriteAppLists() async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM $tableName WHERE ${AppListItem.db_star} = "1"');
    if (result.length == 0) return [];
    List<AppListItem> appLists = [];
    for (Map<String, dynamic> map in result) {
      appLists.add(new AppListItem.fromMap(map));
    }
    return appLists;
  }

  //TODO escape not allowed characters eg. ' " '
  /// Inserts or replaces the book.
  Future updateAppList(AppListItem book) async {
    var db = await _getDb();
    await db.rawInsert(
        'INSERT OR REPLACE INTO '
        '$tableName(${AppListItem.db_id}, ${AppListItem.db_title}, ${AppListItem.db_url}, ${AppListItem.db_star}, ${AppListItem.db_creator}, ${AppListItem.db_description})'
        ' VALUES(?, ?, ?, ?, ?, ?, ?, ?)',
        [
          book.id,
          book.title,
          book.url,
          book.starred ? 1 : 0,
          book.creator,
          book.description,
        ]);
  }

  Future close() async {
    var db = await _getDb();
    return db.close();
  }
}
