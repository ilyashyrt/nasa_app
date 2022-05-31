import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  var initialIndex = 0.obs;
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
    "minites"
  ].obs;
  var opportunityCameraList =
      ["ALL", "fhaz", "rhaz", "navcam", "pancam", "minites"].obs;
  var spiritCameraList =
      ["ALL", "fhaz", "rhaz", "navcam", "pancam", "minites"].obs;

  var connectionIsEnabled = true.obs;
  final Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? streamSubscription;

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
