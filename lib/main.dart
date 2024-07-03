import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vdo_app_api/home_page.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      home:  VideoHomeScreen(),
    );
  }
}
