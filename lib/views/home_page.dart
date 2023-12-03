import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_crud_app/controller/insert_data_controller.dart';
import 'package:sqflite_crud_app/views/data_list_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _idTEController = TextEditingController();
  TextEditingController _titleTEController = TextEditingController();
  TextEditingController _textDetailsTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _idTEController,
                decoration: const InputDecoration(
                  labelText: "Id",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _titleTEController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _textDetailsTEController,
                maxLines: 5,
                decoration: const InputDecoration(
                    labelText: "Text Details",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 12.0,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<InsertDataController>(
                    builder: (_insertDataController) {
                      return ElevatedButton(onPressed: () async{
                        final response = await _insertDataController.insertData(id: int.parse(_idTEController.text.trim()), title: _titleTEController.text.trim(), textDetails: _textDetailsTEController.text.trim());
                        if(response == true){
                          _idTEController.clear();
                          _titleTEController.clear();
                          _textDetailsTEController.clear();
                          Get.snackbar("Successful", "Data has been added",colorText: Colors.white,backgroundColor: Colors.grey.shade600);
                        }else{
                          Get.snackbar("Failed", "Data hasn't been added!",colorText: Colors.white,backgroundColor: Colors.redAccent);
                        }
                      }, child: const Text("Add Data"));
                    }
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(onPressed: () {
                    Get.to(()=>const DataListScreen());
                  }, child: const Text("See Data"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
