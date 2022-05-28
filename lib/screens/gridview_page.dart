import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasa_app/controller/home_page_controller.dart';
import 'package:nasa_app/models/nasa_model.dart';
import 'package:nasa_app/repository/page_status.dart';

PageStorageKey pageStorageKey = const PageStorageKey("pageStorageKey");
final PageStorageBucket pageStorageBucket = PageStorageBucket();

class GridViewPage extends StatefulWidget {
  const GridViewPage({Key? key}) : super(key: key);

  @override
  State<GridViewPage> createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  final HomePageController controller = Get.put(HomePageController());
  ScrollController? scrollController;

  @override
  void initState() {
    createScrollController();
    //controller.getInitialPhotos();
    super.initState();
  }

  void createScrollController() {
    scrollController = ScrollController();
    scrollController?.addListener(loadMorePhotos);
  }

  Future<void> loadMorePhotos() async {
    if (scrollController!.position.pixels >=
            scrollController!.position.maxScrollExtent &&
        controller.pageStatus.value != PageStatus.newPageLoading) {
      print("ffdfsfd");
      await controller.loadMorePhotos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: body(),
    ));
  }

  Widget body() {
    return Obx((() {
      switch (controller.pageStatus.value) {
        case PageStatus.idle:
          return idleWidget();
        case PageStatus.firstPageLoading:
          return firstPageLoadingWidget();
        case PageStatus.firstPageError:
          return firstPageErrorWidget();
        case PageStatus.firstPageNoItemsFound:
          return firstPageNoItemsFoundWidget();
        case PageStatus.newPageLoaded:
        case PageStatus.firstPageLoaded:
          return firstPageLoadedWidget();
        case PageStatus.newPageLoading:
          return newPageLoadingWidget();
        case PageStatus.newPageError:
          return newPageErrorWidget();
        case PageStatus.newPageNoItemsFound:
          return newPageNoItemsFoundWidget();
      }
    }));
  }

  Widget gridViewBuilder() {
    if (scrollController?.hasClients == true) {
      scrollController!.jumpTo(scrollController!.position.maxScrollExtent);
    }
    return PageStorage(
        key: pageStorageKey,
        bucket: pageStorageBucket,
        child: GridView.builder(
            controller: scrollController,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: controller.nasaList.length,
            itemBuilder: (BuildContext context, index) {
              return GridTile(
                child: Image.network(
                  controller.nasaList[index].imgSrc.toString(),
                  fit: BoxFit.cover,
                ),
                footer: GridTileBar(
                  backgroundColor: Colors.black54,
                  title: Center(
                    child: Text(
                      controller.nasaList[index].id.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            }));
  }

  Widget idleWidget() => const SizedBox();

  Widget firstPageLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget firstPageNoItemsFoundWidget() {
    return const Center(
      child: Text("İçerik bulunmadı"),
    );
  }

  Widget firstPageLoadedWidget() {
    return gridViewBuilder();
  }

  Widget firstPageErrorWidget() {
    return const Center(
      child: Text("Hata oluştu"),
    );
  }

  Widget newPageLoadingWidget() {
    return Stack(
      children: [
        gridViewBuilder(),
        bottomIndicator(),
      ],
    );
  }

  Widget newPageNoItemsFoundWidget() {
    return Column(
      children: [
        Expanded(
          child: gridViewBuilder(),
        ),
        bottomMessage("İlave içerik bulunamadı")
      ],
    );
  }

  Widget newPageErrorWidget() {
    return Column(
      children: [
        Expanded(
          child: gridViewBuilder(),
        ),
        bottomMessage("Yeni sayfa bulunamadı")
      ],
    );
  }

  Widget bottomIndicator() {
    return bottomWidget(
      child: const Padding(
        padding: EdgeInsets.all(18.0),
        child: LinearProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget bottomMessage(String message) {
    return bottomWidget(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(message),
      ),
    );
  }

  Widget bottomWidget({required Widget child}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }

  @override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
  }
}




/*
FutureBuilder<Nasa>(
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
    )
*/
