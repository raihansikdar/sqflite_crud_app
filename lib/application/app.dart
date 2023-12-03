import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_crud_app/application/state_holder_binder.dart';
import 'package:sqflite_crud_app/views/home_page.dart';

class SqfliteCrudApp extends StatelessWidget {
  const SqfliteCrudApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: StateHolderBinder(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }
}