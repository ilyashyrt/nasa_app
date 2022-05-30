import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasa_app/base_controller.dart';
import 'package:nasa_app/view/curiosity/curiosity_controller.dart';
import 'package:nasa_app/view/opportunity/opportunity_controller.dart';
import 'package:nasa_app/view/spirit/spirit_controller.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final BaseController baseController;
  const CustomAppBar({Key? key, required this.baseController})
      : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final CuriosityController curiosityController =
      Get.put(CuriosityController());
  final OpportunityController opportunityController =
      Get.put(OpportunityController());
  final SpiritController spiritController = Get.put(SpiritController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppBar(
        actions: [
          widget.baseController.initialIndex.value == 0
              ? PopupMenuButton(
                  itemBuilder: ((context) => buildPopupMenu(
                      widget.baseController.curiosityCameraList,
                      curiosityController: curiosityController)))
              : widget.baseController.initialIndex.value == 1
                  ? PopupMenuButton(
                      itemBuilder: ((context) => buildPopupMenu(
                          widget.baseController.opportunityCameraList,
                          opportunityController: opportunityController)))
                  : PopupMenuButton(
                      itemBuilder: ((context) => buildPopupMenu(
                          widget.baseController.spiritCameraList,
                          spiritController: spiritController)))
        ],
        bottom: TabBar(
            onTap: ((value) {
              widget.baseController.initialIndex.value = value;
            }),
            tabs: const [
              Tab(
                text: "Curiosity",
              ),
              Tab(
                text: "Opportunity",
              ),
              Tab(
                text: "Spirit",
              )
            ]),
      );
    });
  }

  List<PopupMenuItem<dynamic>> buildPopupMenu(
    RxList<String> itemList, {
    CuriosityController? curiosityController,
    OpportunityController? opportunityController,
    SpiritController? spiritController,
  }) {
    return List.generate(itemList.length, ((index) {
      return PopupMenuItem(
        onTap: () {
          if (curiosityController != null) {
            curiosityController.curiosityCameraName.value = itemList[index];
            curiosityController.curiosityList.clear();
            curiosityController.pageKey.value = 1;
            curiosityController.pageStorageIndex.value++;
            curiosityController.getInitialPhotos(cameraName: itemList[index]);
          } else if (opportunityController != null) {
            opportunityController.opportunityCameraName.value = itemList[index];
            opportunityController.opportunityList.clear();
            opportunityController.pageKey.value = 1;
            opportunityController.pageStorageIndex.value++;
            opportunityController.getInitialPhotos(cameraName: itemList[index]);
          } else if (spiritController != null) {
            spiritController.spiritCameraName.value = itemList[index];
            spiritController.spiritList.clear();
            spiritController.pageKey.value = 1;
            spiritController.pageStorageIndex.value++;
            spiritController.getInitialPhotos(cameraName: itemList[index]);
          }
        },
        child: Text(itemList[index].toUpperCase()),
      );
    }));
  }
}
