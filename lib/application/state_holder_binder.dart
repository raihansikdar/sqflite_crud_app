import 'package:get/get.dart';
import 'package:sqflite_crud_app/controller/fetch_data_controller.dart';
import 'package:sqflite_crud_app/controller/insert_data_controller.dart';
import 'package:sqflite_crud_app/controller/update_data_controller.dart';

class StateHolderBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(InsertDataController());
    Get.put(FetchDataController());
    Get.put(UpdateDataController());
  }

}