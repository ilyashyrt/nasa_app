import 'package:flutter/material.dart';
import 'package:nasa_app/view/curiosity/curiosity_screen.dart';
import 'package:nasa_app/view/opportunity/opportunity_screen.dart';
import 'package:nasa_app/view/spirit/spirit_screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(tabs: [
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
            ),
            body: TabBarView(
              children: [
                CuriosityScreen(),
                OpportunityScreen(),
                SpiritScreen(),
              ],
            )));
  }
}
