import 'dart:convert';

import 'package:get/get.dart';
import 'package:nasa_app/constants/app_constants.dart';
import 'package:nasa_app/models/nasa_model.dart';
import 'package:nasa_app/constants/page_status.dart';
import 'package:http/http.dart' as http;

class SpiritController extends GetxController {
  var spiritCameraName = "".obs;
  List<Photos> spiritList = [];
  var pageStatus = PageStatus.idle.obs;
  var pageKey = 1.obs;
  var pageStorageIndex = 0.obs;

  Future<void> getData(int pageKey, {String? cameraName}) async {
    String apiUrl = "";
    if (cameraName == null || cameraName == "" || cameraName == "ALL") {
      apiUrl =
          "https://api.nasa.gov/mars-photos/api/v1/rovers/spirit/photos?sol=1000&api_key=${AppConstants.apiKey}&page=$pageKey";
    } else {
      apiUrl =
          "https://api.nasa.gov/mars-photos/api/v1/rovers/spirit/photos?sol=1000&camera=$cameraName&api_key=${AppConstants.apiKey}&page=$pageKey";
    }
    final response = await http.get(Uri.parse(apiUrl));
    print(apiUrl);
    try {
      for (var map in jsonDecode(response.body)["photos"]) {
        spiritList.add(Photos.fromJson(map));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void onInit() {
    getInitialPhotos();
    super.onInit();
  }

  Future getInitialPhotos({String? cameraName}) async {
    pageStatus.value = PageStatus.firstPageLoading;

    try {
      await getData(1, cameraName: cameraName);
      if (spiritList.isEmpty) {
        pageStatus.value = PageStatus.firstPageNoItemsFound;
      } else {
        pageStatus.value = PageStatus.firstPageLoaded;
      }
    } catch (e) {
      pageStatus.value = PageStatus.firstPageError;
    }
  }

  Future loadMorePhotos({String? cameraName}) async {
    pageStatus.value = PageStatus.newPageLoading;
    pageKey++;

    try {
      int currentPhotosCount = spiritList.length;
      await getData(pageKey.value, cameraName: cameraName);
      if (currentPhotosCount == spiritList.length) {
        pageStatus.value = PageStatus.newPageNoItemsFound;
      } else {
        pageStatus.value = PageStatus.newPageLoaded;
      }
    } catch (e) {
      pageStatus.value = PageStatus.newPageError;
    }
  }

   void buildSpiritControllerOnTap(SpiritController spiritController, RxList<String> itemList, int index) {
    spiritController.spiritCameraName.value = itemList[index];
    spiritController.spiritList.clear();
    spiritController.pageKey.value = 1;
    spiritController.pageStorageIndex.value++;
    spiritController.getInitialPhotos(cameraName: itemList[index]);
  }
}
