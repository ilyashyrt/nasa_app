import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_app/constants/app_constants.dart';
import 'package:nasa_app/models/nasa_model.dart';

class BlurryDialog extends StatelessWidget {
  final List<Photos> photoList;
  final int index;
  final String content;

  const BlurryDialog({
    Key? key,
    required this.photoList,
    required this.index,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: CachedNetworkImage(
            height: 150,
            width: 400,
            imageUrl:
                photoList[index].imgSrc.toString(), //error builder kullan
            fit: BoxFit.fill,
          ),
          content: Container(
              decoration: BoxDecoration(
                border:
                    Border.all(width: 3.0, color: AppConstants.nasaBlueColor),
                borderRadius: const BorderRadius.all(Radius.circular(15.0) //
                    ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Araç Adı: ${photoList[index].rover?.name}"),
                    Text("Kamera Adı: ${photoList[index].camera?.name}"),
                  ],
                ),
              )),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "OK",
                style: TextStyle(
                  color: AppConstants.nasaRedColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
