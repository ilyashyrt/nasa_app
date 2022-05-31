import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:nasa_app/constants/app_constants.dart';
import 'package:nasa_app/constants/page_status.dart';
import 'package:nasa_app/models/nasa_model.dart';
import 'package:http/http.dart' as http;

class BaseController extends GetxController {
  var initialIndex = 0.obs;
  var one = 1.obs;
  var curiosityCameraList = [
    "ALL",
    "fhaz",
    "rhaz",
    "mast",
    "chemcam",
    "mahli",
    "mardi",
    "navcam",
    "pancam",
    "minites",
  ].obs;
  var opportunityCameraList =
      ["ALL", "fhaz", "rhaz", "navcam", "pancam", "minites"].obs;
  var spiritCameraList =
      ["ALL", "fhaz", "rhaz", "navcam", "pancam", "minites"].obs;

  var connectionIsEnabled = true.obs;
  final Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? streamSubscription;

  Future<void> getData(
      Rx<int> pageKey, String roverName, List<Photos> photoList,
      {String? cameraName}) async {
    String apiUrl = "";
    if (cameraName == null || cameraName == "" || cameraName == "ALL") {
      apiUrl =
          "https://api.nasa.gov/mars-photos/api/v1/rovers/$roverName/photos?sol=1000&api_key=${AppConstants.apiKey}&page=$pageKey";
    } else {
      apiUrl =
          "https://api.nasa.gov/mars-photos/api/v1/rovers/$roverName/photos?sol=1000&camera=$cameraName&api_key=${AppConstants.apiKey}&page=$pageKey";
    }
    final response = await http.get(Uri.parse(apiUrl));
    print(apiUrl);
    try {
      for (var map in jsonDecode(response.body)["photos"]) {
        photoList.add(Photos.fromJson(map));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getInitialPhotos(
      Rx<PageStatus> pageStatus, List<Photos> photoList, String roverName,
      {String? cameraName}) async {
    pageStatus.value = PageStatus.firstPageLoading;

    try {
      await getData(one, roverName, photoList, cameraName: cameraName);
      if (photoList.isEmpty) {
        pageStatus.value = PageStatus.firstPageNoItemsFound;
      } else {
        pageStatus.value = PageStatus.firstPageLoaded;
      }
    } catch (e) {
      pageStatus.value = PageStatus.firstPageError;
    }
  }

  Future loadMorePhotos(Rx<int> pageKey, Rx<PageStatus> pageStatus,
      List<Photos> photoList, String roverName,
      {String? cameraName}) async {
    pageStatus.value = PageStatus.newPageLoading;
    pageKey.value++;

    try {
      int currentPhotosCount = photoList.length;
      await getData(pageKey, roverName, photoList, cameraName: cameraName);
      if (currentPhotosCount == photoList.length) {
        pageStatus.value = PageStatus.newPageNoItemsFound;
      } else {
        pageStatus.value = PageStatus.newPageLoaded;
      }
    } catch (e) {
      pageStatus.value = PageStatus.newPageError;
    }
  }

  Future<void> getConnectionState() async {
    ConnectivityResult connectivityResult;
    try {
      connectivityResult = await (connectivity.checkConnectivity());
    } catch (e) {
      throw Exception(e);
    }
    return updateState(connectivityResult);
  }

  updateState(ConnectivityResult result) {
    if (result != ConnectivityResult.mobile &&
        result != ConnectivityResult.wifi) {
      connectionIsEnabled.value = false;
      print(result);
    } else {
      connectionIsEnabled.value = true;
    }
  }

  @override
  void onInit() {
    getConnectionState();
    streamSubscription = connectivity.onConnectivityChanged.listen(updateState);
    super.onInit();
  }
}
