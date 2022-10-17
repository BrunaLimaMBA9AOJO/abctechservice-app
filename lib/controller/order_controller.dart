import 'dart:developer';

import 'package:abctechapp/model/assist.dart';
import 'package:abctechapp/services/geolocation_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class OrderController extends GetxController {
  final GeolocationServiceInterface _geolocationService;
  final formKey = GlobalKey<FormState>();
  final operatorIDController = TextEditingController();
  final selectedAssists = <Assist>[].obs;

  OrderController(this._geolocationService);

  @override
  void onInit() {
    super.onInit();
    _geolocationService.start();
  }

  getLocation(){
    _geolocationService.getPosition().then((value) => log(value.toJson().toString()));
    
  }

  finishStartOrder(){
    getLocation();
  }

  editAssists(){
    Get.toNamed("/assists", arguments: selectedAssists);
  }

}