import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasa_app/base_controller.dart';
import 'package:nasa_app/view/curiosity/curiosity_screen.dart';
import 'package:nasa_app/view/opportunity/opportunity_screen.dart';
import 'package:nasa_app/view/spirit/spirit_screen.dart';
import 'package:nasa_app/widgets/blurry_dialog.dart';
import 'package:nasa_app/widgets/custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BaseController baseController = Get.find<BaseController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: CustomAppBar(
              baseController: baseController,
            ),
            body: Obx(() => baseController.connectionIsEnabled.value == true
                ? TabBarView(
                    children: [
                      CuriosityScreen(),
                      OpportunityScreen(),
                      SpiritScreen(),
                    ],
                  )
                : Center(
                    child: Text("Lütfen internet bağlantınızı kontrol ediniz!"),
                  ))));
  }
}
