import 'package:flutter/material.dart';
import 'package:nasa_app/screens/gridview_page.dart';


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
                  text: "Tab 1",
                ),
                Tab(
                  text: "Tab 2",
                ),
                Tab(
                  text: "Tab 3",
                )
              ]),
            ),
            body: const TabBarView(
              children: [
                GridViewPage(),
                SizedBox(),
                SizedBox(),
              ],
            )));
  }
}
