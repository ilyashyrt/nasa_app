import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasa_app/view/curiosity/curiosity_controller.dart';
import 'package:nasa_app/constants/page_status.dart';
import 'package:nasa_app/view/gridview_page.dart';

class CuriosityScreen extends StatefulWidget {
  const CuriosityScreen({Key? key}) : super(key: key);

  @override
  State<CuriosityScreen> createState() => _CuriosityScreenState();
}

class _CuriosityScreenState extends State<CuriosityScreen> {
  late ScrollController scrollController;
  @override
  void initState() {
    createScrollController();
    //controller.getInitialPhotos();
    super.initState();
  }

  void createScrollController() {
    scrollController = ScrollController();
    scrollController.addListener(
        () => loadMorePhotos(cameraName: controller.curiosityCameraName.value));
  }

  Future<void> loadMorePhotos({String? cameraName}) async {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        controller.pageStatus.value != PageStatus.newPageLoading) {
      await controller.loadMorePhotos(cameraName: cameraName);
      print(cameraName);
    }
  }

  final CuriosityController controller = Get.find<CuriosityController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => GridViewPage(
          pageStatus: controller.pageStatus.value,
          itemCount: controller.curiosityList.length,
          photoList: controller.curiosityList,
          controller: scrollController,
          pageKey: PageStorageKey<String>(
            controller.curiosityCameraName.value == ""
                ? "curiosity"
                : "curiosity" +
                    controller.curiosityCameraName.value +
                    controller.pageStorageIndex.string,
          ),
        ));
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
