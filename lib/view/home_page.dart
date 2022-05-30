import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasa_app/base_controller.dart';
import 'package:nasa_app/view/curiosity/curiosity_screen.dart';
import 'package:nasa_app/view/opportunity/opportunity_screen.dart';
import 'package:nasa_app/view/spirit/spirit_screen.dart';
import 'package:nasa_app/widgets/custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BaseController baseController = Get.put(BaseController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: CustomAppBar(baseController: baseController,),
            body: const TabBarView(
              children: [
                CuriosityScreen(),
                OpportunityScreen(),
                SpiritScreen(),
              ],
            )));
  }
}
