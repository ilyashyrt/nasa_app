import 'package:get/get.dart';
import 'package:nasa_app/base_controller.dart';

class BaseBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<BaseController>(() => BaseController());
  }

}