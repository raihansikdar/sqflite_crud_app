import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_crud_app/database/database_helper.dart';
import 'package:sqflite_crud_app/model/data_list_model.dart';

class UpdateDataController extends GetxController {
  bool _isLoading = false;
  DataListModel _dataListModel = DataListModel();

  bool get isLoading => _isLoading;

  DataListModel get dataListModel => _dataListModel;

  Future<bool> updateData({required int id, required String title, required String textDetails}) async {
    try{
      _isLoading = true;
      update();

      final db = await DatabaseHelper().database;

      _dataListModel = DataListModel(id: id, title: title, textDetails: textDetails);

      final response = await db.update('dataTable', {'title': title, 'textDetails': textDetails}, where: 'id = ?', whereArgs: [id]);


      _isLoading = false;
      if (response > 0) {
        update();
        return true;
      } else {
        update();
        return false;
      }
    }catch(e){
      log("==============>Update Data Error: $e");
      return false;
    }finally{
      await DatabaseHelper().closeDatabase();
    }
  }
}
