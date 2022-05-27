import 'package:flutter/material.dart';
import 'package:nasa_app/repository/http_service.dart';
import 'package:nasa_app/screens/gridview_page.dart';

import '../models/nasa_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HttpService httpService = HttpService();
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
            body: TabBarView(
              children: [
                GridViewPage(),
                const SizedBox(),
                const SizedBox(),
              ],
            )));
  }
}
