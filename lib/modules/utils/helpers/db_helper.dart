import 'dart:developer';
import 'dart:typed_data';
import 'package:budget_tracker_app_11/modules/screens/home/model/spending_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../screens/home/model/category_model.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();
  Database? database;

  //todo:category components
  final String table_name = 'category';
  final String cat_id = 'id';
  final String cat_name = 'cat_name';
  final String cat_image = 'cat_image';

  //todo:Sending components
  final String s_table = 'spending';
  final String s_id = 's_id';
  final String s_name = 's_name';
  final String s_date = 's_date';
  final String s_time = 's_time';
  final String s_mode = 's_mode';
  final String s_amount = 's_amount';
  final String s_type = 's_type';

  initDB() async {
    String db_path = await getDatabasesPath();
    String path = join(db_path, 'rnw.db');
    database =
        await openDatabase(path, version: 2, onCreate: (db, version) async {
      String query =
          "CREATE TABLE $table_name($cat_id INTEGER PRIMARY KEY AUTOINCREMENT,$cat_name TEXT NOT NULL,$cat_image BLOB);";
      String s_query =
          "CREATE TABLE $s_table($s_id INTEGER PRIMARY KEY AUTOINCREMENT,$s_name TEXT NOT NULL,$s_date TEXT NOT NULL,$s_time TEXT NOT NULL,$s_amount TEXT NOT NULL,$s_type TEXT NOT NULL,$s_mode TEXT NOT NULL);";
      await db.execute(query);
      await db.execute(s_query);
    });
  }

  Future<int?> insertCategory({required Category category}) async {
    await initDB();
    String query = "INSERT INTO $table_name($cat_name,$cat_image) VALUES(?,?);";
    List args = [category.cat_name, category.cat_image];
    int? res = await database?.rawInsert(query, args);
    return res;
  }

  Future<List<Category>?> fetchCategory() async {
    await initDB();
    String query = "SELECT * FROM $table_name;";
    List<Map<String, Object?>>? data = await database?.rawQuery(query);
    log("${data}");
    List<Category>? cat_data =
        data?.map((e) => Category.fromDB(data: e)).toList();
    return cat_data;
  }

  Future<int?> deleteQuery({required int id}) async {
    await initDB();
    String query = "DELETE FROM $table_name WHERE id=$id;";
    int? res = await database?.rawDelete(query);
    return res;
  }

  Future<int?> updateCategory(
      {required String name, required Uint8List image, required int id}) async {
    await initDB();
    String query =
        "UPDATE $table_name SET $cat_name=?,$cat_image=? WHERE $cat_id=?;";
    List args = [name, image, id];
    int? res = await database?.rawUpdate(query, args);
    return res;
  }

  Future<List<Category>?> searchCategory({required String searchData}) async {
    await initDB();
    String query =
        "SELECT * FROM $table_name WHERE $cat_name LIKE '%$searchData%'";
    List<Map<String, Object?>>? data = await database?.rawQuery(query);
    log("${data}");
    List<Category>? cat_data =
        data?.map((e) => Category.fromDB(data: e)).toList();
    return cat_data;
  }

  Future<int?> insertSpending({required Spending spending}) async {
    await initDB();
    String query =
        "INSERT INTO $s_table($s_name,$s_date,$s_time,$s_amount,$s_type,$s_mode) VALUES(?,?,?,?,?,?);";
    List args = [
      spending.s_name,
      spending.s_date,
      spending.s_time,
      spending.s_amount,
      spending.s_type,
      spending.s_mode,
    ];
    int? res = await database?.rawInsert(query, args);
    return res;
  }

  Future<List<Spending>> fetchSpending() async {
    await initDB();
    String query = "SELECT * FROM $s_table;";
    List<Map<String, Object?>>? fetchedData = await database?.rawQuery(query);
    List<Spending> spendingData =
        fetchedData!.map((e) => Spending.FROMSQLITE(data: e)).toList();
    return spendingData;
  }

  Future<int?> deleteSpending({required int delete_id}) async {
    await initDB();
    String query = "DELETE FROM $s_table WHERE $s_id=?;";
    List args = [delete_id];
    int? res = await database?.rawDelete(query, args);
    return res;
  }
}
