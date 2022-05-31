import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:nasa_app/base_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test("Opportunity Camera List Test", () async {
    final controller = BaseController();
    Get.put(controller);
    expect(controller.opportunityCameraList.contains("mahli"), false);
    expect(controller.opportunityCameraList.contains("ALL"), true);
  });
}
