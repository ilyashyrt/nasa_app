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
  var isLoading = false.obs;

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

  void buildSpiritControllerOnTap(RxList<String> itemList, int index,
      {String? cameraName}) {
    baseController.buildControllersOnTap(
        spiritCameraName,
        spiritList,
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
