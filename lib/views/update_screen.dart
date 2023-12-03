import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_crud_app/controller/fetch_data_controller.dart';
import 'package:sqflite_crud_app/controller/update_data_controller.dart';
import 'package:sqflite_crud_app/views/data_list_screen.dart';

class UpdateScreen extends StatefulWidget {
  final int id;
  final String title;
  final String textDetails;
  const UpdateScreen({Key? key, required this.id, required this.title, required this.textDetails}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController _idTEController = TextEditingController();
  TextEditingController _titleTEController = TextEditingController();
  TextEditingController _textDetailTEController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _idTEController.text = widget.id.toString();
      _titleTEController.text = widget.title;
      _textDetailTEController.text = widget.textDetails;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Screen"),
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
                controller: _textDetailTEController,
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
              GetBuilder<UpdateDataController>(
                builder: (_updateDataController) {
                  return ElevatedButton(onPressed: () async{
                    final response = await  _updateDataController.updateData(id:int.parse(_idTEController.text.trim()) ,title: _titleTEController.text.trim(),textDetails: _textDetailTEController.text.trim());
                    print("Update ======> $response");
                    if(response == true){
                      _idTEController.clear();
                      _titleTEController.clear();
                      _textDetailTEController.clear();
                      Get.snackbar("Successful", "Data has been Update",colorText:Colors.white,backgroundColor: Colors.grey.shade500);
                      Future.delayed(Duration(seconds: 2)).then((value) {
                        Navigator.pop(context);
                        Get.find<FetchDataController>().fetchData();
                      });
                    }else{
                      Get.snackbar("failed", "Data has not been Update",backgroundColor: Colors.red.shade300,colorText: Colors.white);
                    }
                  }, child: const Text("Update Screen"));
                }
              ),

            ],
          ),
        ),
      ),
    );
  }
}
