import 'package:get/get.dart';

class BaseController extends GetxController {
  var initialIndex = 0.obs;
  var curiosityCameraList = [
    "fhaz",
    "rhaz",
    "mast",
    "chemcam",
    "mahli",
    "mardi",
    "navcam",
    "pancam",
    "minites"
  ].obs;
  var opportunityCameraList =
      ["fhaz", "rhaz", "navcam", "pancam", "minites"].obs;
  var spiritCameraList =
      ["fhaz", "rhaz", "navcam", "pancam", "minites"].obs;
}
