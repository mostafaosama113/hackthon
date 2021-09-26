import 'package:hackathon_fatura/tasks/third_task/models/movie_model.dart';
import 'package:sqflite/sqflite.dart';

class SqlfLite {
  static String dbName = 'favorite';
  static String tableName = 'favorites';
  static Database? db;
  static Future<List<Map>> connect() async {
    db = await openDatabase(dbName, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $tableName (id INTEGER PRIMARY KEY, isFav INTEGER , adult INTEGER , original_title TEXT , overview TEXT , popularity double ,poster_path TEXT , release_date TEXT , vote_average double)');
    });
    return await db!.rawQuery('SELECT * FROM $tableName');
  }

  // static Future update(int id, int newValue) async {
  //   int x = await db!
  //       .rawUpdate('UPDATE $tableName SET isFav = $newValue WHERE id = $id');
  //   return x;
  // }

  static Future delete(int id) async {
    int x = await db!.rawUpdate('DELETE FROM  $tableName  WHERE id = $id');
    return x;
  }

  static Future insert(ResultModel model) async {
    int x = await db!.rawInsert(
        'INSERT INTO $tableName(id , isFav  , adult  , original_title  , overview  , popularity  ,poster_path  , release_date  , vote_average ) VALUES(${model.id} , 1 , ${model.adult! ? 1 : 0} , "${model.title!}" ,  "${model.overview!}" , ${model.popularity} , "${model.posterPath}" , "${model.releaseDate}" , ${model.voteAverage})');
    return x;
  }

  static Future<List<Map>> getFav() async {
    return await db!.rawQuery('SELECT * FROM $tableName');
  }
}
