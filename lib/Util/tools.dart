import 'package:flutter/material.dart';

enum imgType {
  network,
  local
}



Image getImage({required imgType type, required String sourcePath, double width = 20, double height = 20}) {
  if (type == imgType.network) {
    return Image.network(
      sourcePath,
      width: width, // Specify your custom width
      height: height, // Specify your custom height
      fit: BoxFit.cover, // This is to keep aspect ratio
    );
  } else {
    return Image(image: AssetImage(sourcePath), width: width, height: height,);
  }

}





