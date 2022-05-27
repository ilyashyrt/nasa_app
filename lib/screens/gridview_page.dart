import 'package:flutter/material.dart';
import 'package:nasa_app/models/nasa_model.dart';
import 'package:nasa_app/repository/http_service.dart';

class GridViewPage extends StatefulWidget {
  GridViewPage({Key? key}) : super(key: key);

  @override
  State<GridViewPage> createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Nasa>(
      future: httpService.getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: snapshot.data!.photos!.length,
                  itemBuilder: (BuildContext context, index) {
                    return GridTile(
                      child: Image.network(
                        snapshot.data!.photos![index].imgSrc.toString(),
                        fit: BoxFit.cover,
                      ),
                      footer: GridTileBar(
                        backgroundColor: Colors.black54,
                        title: Center(
                          child: Text(
                            snapshot.data!.photos![index].rover!.name
                                .toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    ));
  }
}
