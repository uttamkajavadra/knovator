import 'package:knovator/model/post_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'dart:io' as io;

class PostHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'post.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE post (id INTEGER, userId INTEGER, title TEXT, body TEXT, markAsRead INTEGER, PRIMARY KEY(id))");
  }

  Future<PostModel> insert(PostModel postDB) async {
    var dbClient = await db;
    await dbClient!.insert('post', postDB.toJson());
    return postDB;
  }

  Future<List<PostModel>> get() async {
    var dbClient = await db;
    final List<Map<String, dynamic>> queryResult = await dbClient!.query('post');
    return queryResult.map((e) => PostModel.fromJson(e)).toList();
  }

  Future<bool> postDataAvailable(int postId) async {
    var dbClient = await db;
    final List<Map<String, dynamic>> queryResult = await dbClient!.query('post', where: 'id=?', whereArgs: [postId]);
    if (queryResult.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<int> update(PostModel postDB, int id) async {
    var dbClient = await db;
    return await dbClient!.update('post', postDB.toJson(), where: 'id=?', whereArgs: [id]);
  }
}
