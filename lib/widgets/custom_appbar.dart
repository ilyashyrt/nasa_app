import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasa_app/base_controller.dart';

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
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppBar(
        actions: [
          widget.baseController.initialIndex.value == 0
              ? PopupMenuButton(
                  itemBuilder: ((context) => buildPopupMenu(
                      widget.baseController.curiosityCameraList)))
              : PopupMenuButton(
                  itemBuilder: ((context) => buildPopupMenu(
                      widget.baseController.opportunityAndSpiritCameraList)))
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

  List<PopupMenuItem<dynamic>> buildPopupMenu(RxList<String> itemList) {
    return List.generate(itemList.length, ((index) {
      return PopupMenuItem(child: Text(itemList[index]));
    }));
  }
}
