import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_crud_app/controller/fetch_data_controller.dart';
import 'package:sqflite_crud_app/views/update_screen.dart';

class DataListScreen extends StatefulWidget {
  const DataListScreen({Key? key}) : super(key: key);

  @override
  State<DataListScreen> createState() => _DataListScreenState();
}

class _DataListScreenState extends State<DataListScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<FetchDataController>().fetchData();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data List"),
        actions: [
          IconButton(onPressed: () async{
              Get.find<FetchDataController>().clearData();

          }, icon: const Icon(Icons.delete))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<FetchDataController>(
          builder: (_fetchDataController) {
            print(_fetchDataController.dataList.isEmpty);
            if(_fetchDataController.isLoading){
              return const Center(child: CircularProgressIndicator());
            }else if(_fetchDataController.dataList.isEmpty){
              return const Center(child: Text("Empty",style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),));
            }
            return ListView.separated(
                itemCount: _fetchDataController.dataList.length,
              itemBuilder: (context,index){
                print("==== Screen page length  =====> ${_fetchDataController.dataList.length}");
                return Card(
                    child: ListTile(
                      leading: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            _fetchDataController.dataList[index].id.toString() ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          ),
                        ),
                      ),
                      title: Text(_fetchDataController.dataList[index].title ?? ''),
                      subtitle: Text(_fetchDataController.dataList[index].textDetails ?? ''),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(onPressed: (){
                              Get.to(()=> UpdateScreen(id: _fetchDataController.dataList[index].id!,title: _fetchDataController.dataList[index].title!,textDetails: _fetchDataController.dataList[index].textDetails!,));
                            }, icon: const Icon(Icons.edit),),
                            const Spacer(),
                            IconButton(onPressed: (){
                              Get.find<FetchDataController>().deleteData(id: _fetchDataController.dataList[index].id!);
                              Get.find<FetchDataController>().fetchData();
                              Get.snackbar("Successful", "Data has been delete");
                            }, icon: const Icon(Icons.delete),)
                          ],
                        ),
                      ),
                    ),
                  );
              }, separatorBuilder: (context,index)=> const SizedBox(height: 10,), );
          }
        ),
      ),
    );
  }
}
