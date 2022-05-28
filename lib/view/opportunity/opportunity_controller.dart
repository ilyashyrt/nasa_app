import 'dart:convert';

import 'package:get/get.dart';
import 'package:nasa_app/constants/app_constants.dart';
import 'package:nasa_app/constants/page_status.dart';
import 'package:http/http.dart' as http;
import '../../models/nasa_model.dart';

class OpportunityController extends GetxController{
  List<Photos> opportunityList = [];
  var pageStatus = PageStatus.idle.obs;
  var pageKey = 1.obs;

  Future<void> getData(int pageKey) async {
    String apiUrl =
        "https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity/photos?sol=100&api_key=${AppConstants.apiKey}&page=$pageKey";
    final response = await http.get(Uri.parse(apiUrl));
    print(apiUrl);
    try {
      for (var map in jsonDecode(response.body)["photos"]) {
        opportunityList.add(Photos.fromJson(map));
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

  Future getInitialPhotos() async {
    pageStatus.value = PageStatus.firstPageLoading;

    try {
      await getData(1);
      if (opportunityList.isEmpty) {
        pageStatus.value = PageStatus.firstPageNoItemsFound;
      } else {
        pageStatus.value = PageStatus.firstPageLoaded;
      }
    } catch (e) {
      pageStatus.value = PageStatus.firstPageError;
    }
  }

  Future loadMorePhotos() async {
    pageStatus.value = PageStatus.newPageLoading;
    pageKey++;

    try {
      int currentPhotosCount = opportunityList.length;
      await getData(pageKey.value);
      if (currentPhotosCount == opportunityList.length) {
        pageStatus.value = PageStatus.newPageNoItemsFound;
      } else {
        pageStatus.value = PageStatus.newPageLoaded;
      }
    } catch (e) {
      pageStatus.value = PageStatus.newPageError;
    }
  }
}