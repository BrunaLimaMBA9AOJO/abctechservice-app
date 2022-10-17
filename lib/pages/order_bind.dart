import 'package:abctechapp/controller/order_controller.dart';
import 'package:abctechapp/services/geolocation_service.dart';
import 'package:get/instance_manager.dart';

class OrderBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() => OrderController(GeolocationService()));
  }
}