import 'dart:convert';

import 'package:get/get.dart';
import 'package:nasa_app/base_controller.dart';
import 'package:nasa_app/constants/app_constants.dart';
import 'package:nasa_app/constants/page_status.dart';
import 'package:http/http.dart' as http;
import '../../models/nasa_model.dart';

class OpportunityController extends GetxController {
  final BaseController baseController = Get.put(BaseController());
  var opportunityCameraName = "".obs;
  List<Photos> opportunityList = [];
  var pageStatus = PageStatus.idle.obs;
  var pageKey = 1.obs;
  var pageStorageIndex = 0.obs;
  var roverName = "opportunity".obs;

  Future<void> getData({String? cameraName}) async {
    await baseController.getData(pageKey, roverName.value, opportunityList,
        cameraName: cameraName);
  }

  Future getInitialPhotos({String? cameraName}) async {
    await baseController.getInitialPhotos(
        pageStatus, opportunityList, roverName.value,
        cameraName: cameraName);
  }

  Future loadMorePhotos({String? cameraName}) async {
    await baseController.loadMorePhotos(
        pageKey, pageStatus, opportunityList, roverName.value,
        cameraName: cameraName);
  }

  @override
  void onInit() {
    getInitialPhotos();
    super.onInit();
  }

  void buildOpportunityControllerOnTap(
      OpportunityController opportunityController,
      RxList<String> itemList,
      int index) {
    opportunityController.opportunityCameraName.value = itemList[index];
    opportunityController.opportunityList.clear();
    opportunityController.pageKey.value = 1;
    opportunityController.pageStorageIndex.value++;
    opportunityController.getInitialPhotos(cameraName: itemList[index]);
  }
}
