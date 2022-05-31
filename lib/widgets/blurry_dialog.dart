import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_app/constants/app_constants.dart';
import 'package:nasa_app/models/nasa_model.dart';

class BlurryDialog extends StatelessWidget {
  final List<Photos> photoList;
  final int index;

  const BlurryDialog({
    Key? key,
    required this.photoList,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: buildImagesColumn(),
          content: Container(
              decoration: BoxDecoration(
                border:
                    Border.all(width: 1.5, color: AppConstants.nasaBlueColor),
                borderRadius: const BorderRadius.all(Radius.circular(15.0) //
                    ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildDetailColumn(context),
              )),
          actions: <Widget>[
            buildOKButton(context),
          ],
        ));
  }

  TextButton buildOKButton(BuildContext context) {
    return TextButton(
      child: const Text(
        AppConstants.okText,
        style: TextStyle(
          color: AppConstants.nasaBlueColor,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Column buildImagesColumn() {
    return Column(
      children: [
        Image.asset(
          AppConstants.nasaLogoAsset,
          width: 60,
          height: 60,
        ),
        const SizedBox(
          height: 10,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(
            height: 150,
            width: 400,
            imageUrl: photoList[index].imgSrc.toString(), //error builder kullan
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }

  Column buildDetailColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildRichText(context, AppConstants.roverNameText, photoList[index].rover?.name),
        buildRichText(context, AppConstants.cameraNameText, photoList[index].camera?.name),
        buildRichText(context, AppConstants.earthDateText, photoList[index].earthDate),
        buildRichText(
            context, AppConstants.launchDateText, photoList[index].rover?.launchDate),
        buildRichText(
            context, AppConstants.landingDateText, photoList[index].rover?.landingDate),
        buildRichText(
            context, AppConstants.statusText, photoList[index].rover?.status?.toUpperCase()),
      ],
    );
  }

  RichText buildRichText(BuildContext context, String title, String? content) {
    return RichText(
        text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
      TextSpan(text: title, style: const TextStyle(fontSize: 15)),
      TextSpan(
          text: content,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
    ]));
  }
}
