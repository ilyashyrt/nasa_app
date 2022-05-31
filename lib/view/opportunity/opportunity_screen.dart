import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasa_app/view/opportunity/opportunity_controller.dart';
import 'package:nasa_app/constants/page_status.dart';
import 'package:nasa_app/view/gridview_page.dart';

class OpportunityScreen extends StatefulWidget {
  const OpportunityScreen({Key? key}) : super(key: key);

  @override
  State<OpportunityScreen> createState() => _OpportunityScreenState();
}

class _OpportunityScreenState extends State<OpportunityScreen> {
  late ScrollController scrollController;
  final OpportunityController controller = Get.find<OpportunityController>();

  @override
  void initState() {
    createScrollController();
    //controller.getInitialPhotos();
    super.initState();
  }

  void createScrollController() {
    scrollController = ScrollController();
    scrollController.addListener(() =>
        loadMorePhotos(cameraName: controller.opportunityCameraName.value));
  }

  Future<void> loadMorePhotos({String? cameraName}) async {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        controller.pageStatus.value != PageStatus.newPageLoading) {

      await controller.loadMorePhotos(cameraName: cameraName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => GridViewPage(
          pageStatus: controller.pageStatus.value,
          itemCount: controller.opportunityList.length,
          photoList: controller.opportunityList,
          controller: scrollController,
          pageKey: PageStorageKey<String>(
            controller.opportunityCameraName.value == ""
                ? "opportunity"
                : "opportunity" +
                    controller.opportunityCameraName.value +
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
