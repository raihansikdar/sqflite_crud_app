import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_crud_app/database/database_helper.dart';
import 'package:sqflite_crud_app/model/data_list_model.dart';

class InsertDataController extends GetxController {
  bool _isLoading = false;
  DataListModel _dataListModel = DataListModel();

  bool get isLoading => _isLoading;

  DataListModel get dataListModel => _dataListModel;

  Future<bool> insertData({required int id, required String title, required String textDetails}) async {
   try{
     _isLoading = true;
     update();

     final db = await DatabaseHelper().database;

      // Check if the ID already exists in the database
      final existingRecord = await db.query('dataTable',where: 'id = ?',whereArgs: [id]);
      if(existingRecord.isNotEmpty){
        // ID already exists, show snackbar and return false
        update();
        Get.snackbar("ID Taken", "Please choose another ID",backgroundColor: Colors.yellow);
        return false;
      }

     _dataListModel = DataListModel(id: id, title: title, textDetails: textDetails);

     final response = await db.insert('dataTable', _dataListModel.toJson());
     log("=======insert Id:======> $id");
     _isLoading = false;
     if (response > 0) {
       update();
       return true;
     } else {
       update();
       return false;
     }
   }catch(e){
     log("==============>Insert Data Error: $e");
     return false;
   }finally{
     await DatabaseHelper().closeDatabase();
   }
  }
}
