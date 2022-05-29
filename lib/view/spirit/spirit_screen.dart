import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasa_app/view/spirit/spirit_controller.dart';
import 'package:nasa_app/constants/page_status.dart';
import 'package:nasa_app/view/gridview_page.dart';

class SpiritScreen extends StatefulWidget {
  SpiritScreen({Key? key}) : super(key: key);

  @override
  State<SpiritScreen> createState() => _SpiritScreenState();
}

class _SpiritScreenState extends State<SpiritScreen> {
  final SpiritController controller = Get.put(SpiritController());
  late ScrollController scrollController;
  @override
  void initState() {
    createScrollController();
    //controller.getInitialPhotos();
    super.initState();
  }

  void createScrollController() {
    scrollController = ScrollController();
    scrollController.addListener(() => loadMorePhotos());
  }

  Future<void> loadMorePhotos() async {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        controller.pageStatus.value != PageStatus.newPageLoading) {
      print("ffdfsfd");
      await controller.loadMorePhotos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => GridViewPage(
        pageStatus: controller.pageStatus.value,
        itemCount: controller.spiritList.length,
        photoList: controller.spiritList,
        controller: scrollController,
        pageKey: const PageStorageKey<String>('spirit')));
  }
}
