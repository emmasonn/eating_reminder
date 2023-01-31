import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';

class SqliteDatabaseHelper {
  //declare db name
  static const _databaseName = 'foods.db';
  //db version
  static const _databaseVersion = 1;

  //declare food table name;
  static const foodTable = 'foods_table';
  static const foodId = 'id';

  //declare lock
  static var lock = Lock();

  //declare briteDatabase
  static late BriteDatabase _streamDatabase;

  //make this a singleton class
  SqliteDatabaseHelper._privateConstructor();

  static final SqliteDatabaseHelper instance =
      SqliteDatabaseHelper._privateConstructor();

  //only have a single app-wide reference to the
  //database
  static Database? _database;

  //SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    //query to create table
    //make id unique to avoid duplicate in the database
    //make sure that the last field doesnt end with comma ,
    await db.execute('''CREATE TABLE $foodTable (
    $foodId TEXT UNIQUE,
    period TEXT,
    title TEXT,
    imageUrl TEXT,
    scheduleId TEXT,
    day TEXT,
    mealTime TEXT,
    ownerId TEXT,
    recipe TEXT,
    description TEXT,
    lastUpdated TEXT 
    )''');
  }


  Future<Database> _initDatabase() async {
    //create a document directory
    final documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(
      documentsDirectory.path,
      _databaseName,
    );

    //turn off debugging before deploying app to store(s)
    Sqflite.setDebugModeOn(true);

    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<Database> get database async {
    //return the existing database
    if (_database != null) return _database!;

    //Use this object to prevent concurrent access to data
    await lock.synchronized(() async {
      if (_database == null) {
        _database = await _initDatabase();
        _streamDatabase = BriteDatabase(_database!);
      }
    });
    return _database!;
  }

  Future<BriteDatabase> get streamDatabase async {
    await database;
    return _streamDatabase;
  }

  void close() {
    _streamDatabase.close();
  }
}
