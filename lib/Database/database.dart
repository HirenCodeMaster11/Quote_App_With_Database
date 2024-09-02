import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../Modal/modal.dart';

class DatabaseHelper {
  static final DatabaseHelper databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'quotes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE quotes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
            category TEXT,
            quote TEXT,
            author TEXT,
            isLiked TEXT
          )
          ''',
        );
      },
    );
  }

  Future<int> insertLikedQuote(
      String category, String quote, String author, String isLiked) async {
    final db = await database;
    String sql = '''
    INSERT INTO quotes (category, quote, author, isLiked)
    VALUES (?, ?, ?, ?)
    ''';
    List args = [category, quote, author, isLiked];
    return await db.rawInsert(sql, args);
  }

  Future readLikedQuotes() async {
    final db = await database;
    String sql = '''
    SELECT * FROM quotes
    ''';
    final map = await db.rawQuery(sql);
    return List.generate(
      map.length,
      (index) => QuoteModal.fromJson(map[index]),
    );
  }

  Future<int> deleteLikedQuote(int id) async {
    final db = await database;
    String sql = '''
    DELETE FROM quotes WHERE id = ?
    ''';
    return await db.rawDelete(sql, [id]);
  }

  Future<bool> isQuoteLiked(String quote) async {
    final db = await database;
    String sql = '''
  SELECT * FROM quotes WHERE quote = ?
  ''';
    final result = await db.rawQuery(sql, [quote]);
    return result.isNotEmpty;
  }
}
