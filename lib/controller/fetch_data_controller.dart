import 'dart:developer';

import 'package:get/get.dart';
import 'package:sqflite_crud_app/database/database_helper.dart';
import 'package:sqflite_crud_app/model/data_list_model.dart';

class FetchDataController extends GetxController{
  bool _isLoading = false;
  List<DataListModel> _dataList = [];

  bool get isLoading => _isLoading;
  List<DataListModel> get dataList => _dataList;

  Future<bool> fetchData() async {
    try{
      _isLoading = true;
      update();

      final db = await DatabaseHelper().database;
      //final response = await db.query('dataTable',orderBy: "id ASC");
      final response = await db.query('dataTable');

      log("fetch Data : $response");

      _isLoading = false;
      if (response.isNotEmpty) {
        _dataList = response.map((data) => DataListModel.fromJson(data)).toList();
        update();
        return true;
      } else {
        update();
        return false;
      }
    }catch(e){
      log("==============> Fetch Data Error: $e");
      return false;
    }
  }
  Future<bool> deleteData({required int id}) async {
    try{
      _isLoading = true;
      update();

      final db = await DatabaseHelper().database;
      final response = await db.delete('dataTable', where: 'id = ?', whereArgs: [id]);
     
      _isLoading = false;
      if (response >= 0) {
        _dataList.removeWhere((element) => element.id == id);

        update();
        return true;
      } else {
        update();
        return false;
      }
    }catch(e){
      log("==============>Delete Data Error: $e");
      return false;
    }
  }

  Future<bool>clearData() async{
    try{
      _isLoading = true;
      update();

      final db = await DatabaseHelper().database;
      final response =  await db.rawDelete("DELETE FROM dataTable"); // table name dataTable

      _isLoading = false;
      if(response > 0){
        _dataList.clear(); // Clear the local list
        Get.snackbar("Successful", "Data has been Clear");
        update();
        return true;
      }else{
        update();
        return false;
      }

    }catch(e){
      log("==============>Clear Data Error: $e");
      return false;
    }finally{
      await DatabaseHelper().closeDatabase();
    }

  }
}