
import 'package:get/get.dart';
import 'package:nasa_app/base_controller.dart';
import 'package:nasa_app/models/nasa_model.dart';
import 'package:nasa_app/constants/page_status.dart';

class SpiritController extends GetxController {
  final BaseController baseController = Get.put(BaseController());
  var spiritCameraName = "".obs;
  List<Photos> spiritList = [];
  var pageStatus = PageStatus.idle.obs;
  var pageKey = 1.obs;
  var pageStorageIndex = 0.obs;
  var roverName = "spirit".obs;

  Future<void> getData({String? cameraName}) async {
    await baseController.getData(pageKey, roverName.value, spiritList,
        cameraName: cameraName);
  }

  Future getInitialPhotos({String? cameraName}) async {
    await baseController.getInitialPhotos(
        pageStatus, spiritList, roverName.value,
        cameraName: cameraName);
  }

  Future loadMorePhotos({String? cameraName}) async {
    await baseController.loadMorePhotos(
        pageKey, pageStatus, spiritList, roverName.value,
        cameraName: cameraName);
  }

  @override
  void onInit() {
    getInitialPhotos();
    super.onInit();
  }

  void buildSpiritControllerOnTap(
      SpiritController spiritController, RxList<String> itemList, int index) {
    spiritController.spiritCameraName.value = itemList[index];
    spiritController.spiritList.clear();
    spiritController.pageKey.value = 1;
    spiritController.pageStorageIndex.value++;
    spiritController.getInitialPhotos(cameraName: itemList[index]);
  }
}
