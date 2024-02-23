import 'package:flutter/material.dart';
import '../Util/tools.dart';


Widget circularNetworkImage(String imageUrl, int imgtype) {
  return ClipOval(
    child: getImage(type : imgtype,sourcePath: imageUrl) //TODO : here give the custom paras
  );
}


class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Column(
        children: [
          circularNetworkImage(imageUrl),
          Text("hello"),
        ],
      ) //Text("This is a new screen for profile"),

      )
    ;
  }
}
