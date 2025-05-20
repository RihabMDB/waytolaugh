import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

import 'package:waytolaugh/models/joke_model.dart';
import 'package:waytolaugh/utils/utils.dart';

class DatabaseHelper {
  static const _databaseName = "jokes.db";
  static const _databaseVersion = 1;

  // make this a singleton class

  // define a private constructor // createInstance is the constructor name
  DatabaseHelper._createInstance();
  // singleton object // execute only one
  factory DatabaseHelper() => DatabaseHelper._createInstance();

  static Database? _database;

  // Getter
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  // opens the database (and creates it if it doesn't exist)
  initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    print("db init ---------------------------- ");
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreateDB,
    );
  }

  void _onCreateDB(Database db, int version) async {
    print("Create DB ------------- ");
    await db.execute('''
          CREATE TABLE ${Utils.tableJoke}  (
            ${Utils.columnId} INTEGER PRIMARY KEY,
            ${Utils.columnSetup} TEXT NOT NULL,
            ${Utils.columnPunchline} TEXT NOT NULL
          )
          ''');
  }

  Future<void> insertJoke(Joke joke) async {
    // Get a reference to the database.
    final db = await database;
    var result = await db!.insert(
      Utils.tableJoke,
      joke.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    print("Joke added $result ---------------------------- ");
  }

  Future<Joke?> getJoke(int id) async {
    List<Map> maps = await _database!.query(Utils.tableJoke,
        columns: [Utils.columnId, Utils.columnSetup, Utils.columnPunchline],
        where: '${Utils.columnId} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Joke.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Joke>?> getAllJokes() async {
    final db = await database;
    final jokes = await db!.rawQuery('SELECT * FROM ${Utils.tableJoke}');
    if (jokes.isNotEmpty) {
      return jokes.map((joke) => Joke.fromMap(joke)).toList();
    }
    return null;
  }

  Future<void> deleteJoke(int id) async {
    Database? db = await database;
    print("id = $id ------------");
    //var data = await db!.rawDelete('DELETE from Joke WHERE id=?', [id]);
    var data = await db?.delete(Utils.tableJoke,
        where: '${Utils.columnId} = ?', whereArgs: [id]);
    print(' result $data ----------------------------');
  }

  Future<int> getSize() async {
    Database? db = await database;
    return firstIntValue(
            await db!.query(Utils.tableJoke, columns: ['COUNT(*)'])) ??
        0;
  }

  Future close() async => _database!.close();
}
