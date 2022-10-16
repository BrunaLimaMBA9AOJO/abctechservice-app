import 'package:abctechapp/pages/home_bind.dart';
import 'package:abctechapp/pages/home_page.dart';
import 'package:abctechapp/provider/assist_provider.dart';
import 'package:abctechapp/services/assist_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

void main() {
  initServices();
  runApp(const MyApp());
}

void initServices() {
  Get.lazyPut(() => AssistService(assistProvider: AssistProvider()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ABC Tech App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      getPages: [
        GetPage(name: "/", page: () => const HomePage(), binding: HomeBind())
      ],
    );
  }
}

