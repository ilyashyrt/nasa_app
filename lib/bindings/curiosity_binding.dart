import 'package:get/get.dart';
import 'package:nasa_app/view/curiosity/curiosity_controller.dart';

class CuriosityBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CuriosityController>(() => CuriosityController());
  }
}