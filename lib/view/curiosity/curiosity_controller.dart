import 'package:get/get.dart';
import 'package:nasa_app/base_controller.dart';
import 'package:nasa_app/models/nasa_model.dart';

import 'package:nasa_app/constants/page_status.dart';

class CuriosityController extends GetxController {
  final BaseController baseController = Get.put(BaseController());
  var curiosityCameraName = "".obs;
  var curiosityCameraList = [].obs;
  List<Photos> curiosityList = [];
  var pageStatus = PageStatus.idle.obs;
  var pageKey = 1.obs;
  var pageStorageIndex = 0.obs;
  var roverName = "curiosity".obs;

  Future<void> getData({String? cameraName}) async {
    await baseController.getData(pageKey, roverName.value, curiosityList,
        cameraName: cameraName);
  }

  Future getInitialPhotos({String? cameraName}) async {
    await baseController.getInitialPhotos(
        pageStatus, curiosityList, roverName.value,
        cameraName: cameraName);
  }

  Future loadMorePhotos({String? cameraName}) async {
    await baseController.loadMorePhotos(
        pageKey, pageStatus, curiosityList, roverName.value,
        cameraName: cameraName);
  }

  void buildCuriosityControllerOnTap(RxList<String> itemList, int index,
      {String? cameraName}) {
    baseController.buildControllersOnTap(
        curiosityCameraName,
        curiosityList,
        pageKey,
        pageStorageIndex,
        getInitialPhotos(cameraName: cameraName),
        itemList,
        index);
  }

  @override
  void onInit() {
    getInitialPhotos();
    super.onInit();
  }
}
