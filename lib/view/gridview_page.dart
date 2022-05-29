import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasa_app/view/curiosity/curiosity_controller.dart';
import 'package:nasa_app/models/nasa_model.dart';
import 'package:nasa_app/constants/page_status.dart';


final PageStorageBucket pageStorageBucket = PageStorageBucket();
 
class GridViewPage extends StatefulWidget {
  final PageStatus pageStatus;
  final int itemCount;
  final List<Photos> photoList;
  final ScrollController controller;
  final Key pageKey;
  const GridViewPage(
      {Key? key,
      required this.pageStatus,
      required this.itemCount,
      required this.photoList,
      required this.controller, required this.pageKey})
      : super(key: key);

  @override
  State<GridViewPage> createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  
  final CuriosityController controller = Get.put(CuriosityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: body(widget.pageStatus, widget.itemCount, widget.photoList,
          widget.controller,widget.pageKey),
    ));
  }

  Widget body(PageStatus pageStatus, int itemCount, List<Photos> photoList,
      ScrollController controller,Key pageKey) {
    switch (pageStatus) {
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
        return firstPageLoadedWidget(itemCount, photoList, controller,pageKey);
      case PageStatus.newPageLoading:
        return newPageLoadingWidget(itemCount, photoList, controller,pageKey);
      case PageStatus.newPageError:
        return newPageErrorWidget(itemCount, photoList, controller,pageKey);
      case PageStatus.newPageNoItemsFound:
        return newPageNoItemsFoundWidget(itemCount, photoList, controller,pageKey);
    }
  }

  Widget gridViewBuilder(int itemCount, List<Photos> photoList,
      ScrollController scrollController,Key pageKey) {
    if (scrollController.hasClients == true) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
    return PageStorage(
        key: pageKey,
        bucket: pageStorageBucket,
        child: GridView.builder(
            controller: scrollController,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: itemCount,
            itemBuilder: (BuildContext context, index) {
              return GridTile(
                child: CachedNetworkImage(
                  imageUrl: photoList[index].imgSrc.toString(),
                  fit: BoxFit.cover,
                ),
                footer: GridTileBar(
                  backgroundColor: Colors.black54,
                  title: Center(
                    child: Text(
                      photoList[index].id.toString(),
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

  Widget firstPageLoadedWidget(
      int itemCount, List<Photos> photoList, ScrollController controller,Key pageKey) {
    return gridViewBuilder(itemCount, photoList, controller,pageKey);
  }

  Widget firstPageErrorWidget() {
    return const Center(
      child: Text("Hata oluştu"),
    );
  }

  Widget newPageLoadingWidget(
      int itemCount, List<Photos> photoList, ScrollController controller,Key pageKey) {
    return Stack(
      children: [
        gridViewBuilder(itemCount, photoList, controller,pageKey),
        bottomIndicator(),
      ],
    );
  }

  Widget newPageNoItemsFoundWidget(
      int itemCount, List<Photos> photoList, ScrollController controller,Key pageKey) {
    return Column(
      children: [
        Expanded(
          child: gridViewBuilder(itemCount, photoList, controller,pageKey),
        ),
        bottomMessage("İlave içerik bulunamadı")
      ],
    );
  }

  Widget newPageErrorWidget(
      int itemCount, List<Photos> photoList, ScrollController controller,Key pageKey) {
    return Column(
      children: [
        Expanded(
          child: gridViewBuilder(itemCount, photoList, controller,pageKey),
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
}
