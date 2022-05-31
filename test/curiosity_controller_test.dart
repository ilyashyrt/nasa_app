import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:nasa_app/base_controller.dart';
import 'package:nasa_app/view/curiosity/curiosity_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test("Curiosity camera onTap test", () {
    final baseController = BaseController();
    final controller = CuriosityController();
    Get.put(baseController);
    Get.put(controller);

    controller.buildCuriosityControllerOnTap(
        baseController.curiosityCameraList, 3);
    expect(controller.curiosityCameraName.value, "mast");
  });
}
