import 'package:get/get.dart';
import 'package:nasa_app/view/spirit/spirit_controller.dart';

class SpiritBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpiritController>(() => SpiritController());
  }
}
