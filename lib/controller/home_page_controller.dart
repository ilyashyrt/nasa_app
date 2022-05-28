import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:nasa_app/models/nasa_model.dart';

import 'package:nasa_app/repository/page_status.dart';
import 'package:http/http.dart' as http;

import '../constants/app_constants.dart';

class HomePageController extends GetxController {
  List<Photos> nasaList = [];
  var pageStatus = PageStatus.idle.obs;
  var pageKey = 1.obs;

  Future<void> getData(int pageKey) async {
    String apiUrl =
        "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=100&api_key=${AppConstants.apiKey}&page=$pageKey";
    final response = await http.get(Uri.parse(apiUrl));
    print(apiUrl);
    try {
      for (var map in jsonDecode(response.body)["photos"]) {
        nasaList.add(Photos.fromJson(map));
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
      if (nasaList.isEmpty) {
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
      int currentPhotosCount = nasaList.length;
      await getData(pageKey.value);
      if (currentPhotosCount == nasaList.length) {
        pageStatus.value = PageStatus.newPageNoItemsFound;
      } else {
        pageStatus.value = PageStatus.newPageLoaded;
      }
    } catch (e) {
      pageStatus.value = PageStatus.newPageError;
    }
  }


}
