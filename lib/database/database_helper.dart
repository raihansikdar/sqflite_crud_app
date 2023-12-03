import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static Database? _database;

  Future<Database> get database async{
    if(_database != null){
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async{
    final Directory directory  = await getApplicationDocumentsDirectory();
    final path = join(directory.path,'sqlite_crud.db');

    await databaseExists(path);
    final exits = await databaseExists(path);

    if(exits){
      log("{===================>Database exist}");
    }else{
      log("{===================>Database not exist}");
    }

    return await openDatabase(path,version: 1,onCreate: _onCreate);

  }

  Future<void>_onCreate(Database db, int version)async{
    await db.execute(
      '''
      CREATE TABLE dataTable(id INTEGER PRIMARY KEY,title TEXT,textDetails TEXT)
      '''
    );
  }
  Future<void>closeDatabase() async{
    if(_database !=null && _database!.isOpen){
      await _database!.close();
      _database = null;
      log("{===================>Database closed}");
    }
  }
}