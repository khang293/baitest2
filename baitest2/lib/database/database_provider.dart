import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String DATABASE_NAME = 'jokes.db';
  static const String TABLE_NAME = 'jokes';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_CONTENT = 'content';
  static const String COLUMN_RATING = 'rating';

  Future<Database> open() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, DATABASE_NAME);
    return openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $TABLE_NAME (
        $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $COLUMN_CONTENT TEXT,
        $COLUMN_RATING INTEGER
      )
      ''');
    
    await db.insert(TABLE_NAME, {COLUMN_CONTENT: 'Một đứa trẻ hỏi cha mình, "Con người được sinh ra như thế nào?" Vì vậy, cha ông nói, "Adam và Eva sinh ra những đứa trẻ, sau đó những đứa trẻ của họ trở thành người lớn và sinh ra những đứa trẻ, v.v.\n "Đứa trẻ sau đó đến gặp mẹ nó, hỏi bà câu hỏi tương tự và bà nói với nó, "Chúng ta là những con khỉ sau đó chúng ta tiến hóa để trở thành như bây giờ.\n"Đứa trẻ chạy lại với cha và nói: "Cha đã nói dối con!" Cha anh trả lời: "Không, mẹ con đang nói về gia đình của bà ấy."', COLUMN_RATING: 0});
    await db.insert(TABLE_NAME, {COLUMN_CONTENT: 'Cô giáo: "Các con ơi, con gà mang đến cho các con cái gì?" Sinh viên: "Thịt!" Cô giáo: "Tốt lắm! Bây giờ con lợn cho cô cái gì?" Sinh viên: "Thịt xông khói!" \n Giáo viên: "Tuyệt vời! Và con bò béo cho bạn cái gì?" Học sinh: "Bài tập về nhà!"', COLUMN_RATING: 0});
    await db.insert(TABLE_NAME, {COLUMN_CONTENT: 'Giáo viên hỏi Jimmy, "Tại sao con mèo của bạn ở trường hôm nay Jimmy?" Jimmy vừa khóc vừa trả lời: "Bởi vì tôi nghe bố tôi nói với mẹ tôi, \nTôi sẽ ăn con mèo đó sau khi Jimmy đi học hôm nay!"', COLUMN_RATING: 0});
    await db.insert(TABLE_NAME, {COLUMN_CONTENT: 'Một bà nội trợ, một kế toán và một luật sư được hỏi "2+2 bằng bao nhiêu?" Bà nội trợ trả lời: "Bốn!". Người kế toán nói: "Tôi nghĩ là 3 hoặc 4. \n Hãy để tôi chạy những con số đó qua bảng tính của tôi một lần nữa." Luật sư kéo rèm, giảm ánh sáng và hỏi bằng một giọng thì thầm, "Anh muốn nó bao nhiêu?"', COLUMN_RATING: 0});
  }

  Future<List<Map<String, dynamic>>> getJokes() async {
    final db = await open();
    return db.query(TABLE_NAME);
  }

  Future<void> updateJokeRating(int id, int rating) async {
    final db = await open();
    await db.update(TABLE_NAME, {COLUMN_RATING: rating}, where: '$COLUMN_ID = ?', whereArgs: [id]);
  }
}
