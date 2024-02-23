import 'package:flutter/material.dart';

Image getImage({int type, String sourcePath, double width, double height}) {
  if (type == 1) {
    return Image.network(
      sourcePath,
      width: width, // Specify your custom width
      height: height, // Specify your custom height
      fit: BoxFit.cover, // This is to keep aspect ratio
    );
  } else {
    return Image.asset(
      sourcePath,
      width: width,
      height: height,
      fit: fit,
    );
  }

}