import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class SqlHelper{
  static Future<void> createTables(Database database) async {
    await database.execute(""" CREATE TABLE contacts(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    nom TEXT,
    tel TEXT,
    createdAT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }
  static Future<Database> db() async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    return openDatabase('first.db',version:1,
      onCreate: (Database database, int version) async{
        await createTables(database);
      },
    );
  }
  static Future<int> createConatct(String nom, String tel) async{
    final db= await SqlHelper.db();
    final data= {'nom':nom,'tel':tel};
    final id= await db.insert('contacts', data,conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }
  static Future<List<Map<String,dynamic>>> getConatcts() async{
    final db = await SqlHelper.db();
    return db.query('contacts',orderBy: "id");
  }

  static Future<List<Map<String,dynamic>>> getcontact()  async {
    final db=await SqlHelper.db();
    return db.query('contact',orderBy: "id");

  }
  static Future<int> updateContact(
      int id,String nom,String tel
      ) async{
    final db= await SqlHelper.db();
    final data = {
      'nom': nom,
      'tel':tel,
      'createdAt': DateTime.now().toString()
    };
    final result=
    await db.update('contacts',data,where: "id= ?",whereArgs: [id]);
    return result;
  }
  static Future<void> deletecontact(int id)async {
    final db = await SqlHelper.db();
    try {
      await db.delete("contacts", where: "id=?", whereArgs: [id]);
    } catch (err) {
      debugPrint("something went wrong when deleting an item:$err");
    }
  }}
