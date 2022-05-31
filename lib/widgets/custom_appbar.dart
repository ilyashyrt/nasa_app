import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasa_app/base_controller.dart';
import 'package:nasa_app/constants/app_constants.dart';
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
        title: const Text(AppConstants.marsRoverPhotosText),
        centerTitle: true,
        backgroundColor: AppConstants.nasaBlueColor,
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
                text: AppConstants.curiosityText,
              ),
              Tab(
                text: AppConstants.opportunityText,
              ),
              Tab(
                text: AppConstants.spiritText,
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
          buildControllersOnTap(curiosityController, itemList, index,
              opportunityController, spiritController);
        },
        child: Text(itemList[index].toUpperCase()),
      );
    }));
  }

  void buildControllersOnTap(
      CuriosityController? curiosityController,
      RxList<String> itemList,
      int index,
      OpportunityController? opportunityController,
      SpiritController? spiritController) {
    if (curiosityController != null) {
      curiosityController.buildCuriosityControllerOnTap(itemList, index,
          cameraName: itemList[index]);
    } else if (opportunityController != null) {
      opportunityController.buildOpportunityControllerOnTap(itemList, index,
          cameraName: itemList[index]);
    } else if (spiritController != null) {
      spiritController.buildSpiritControllerOnTap(itemList, index,
          cameraName: itemList[index]);
    }
  }
}
