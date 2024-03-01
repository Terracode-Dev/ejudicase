import 'package:flutter/material.dart';
import '../Util/tools.dart';
import '../Util/resources.dart';


Widget circularNetworkImage(String imageUrl, imgType imgtype) {
  return ClipOval(
    child: getImage(type : imgtype,sourcePath: imageUrl) //TODO : here give the custom paras
  );
}


class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var TextContent =  {
        "user" : "Daneil Pushpakumara",
        "level" : 4
    };

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: ColourStack["black"],

      ),
      body: Container(
          //padding: Padding(),
          child : Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //getImage(type: imgType.local, sourcePath: "assets/images/lawyerAppLogo.png" , width: 70, height: 70),
              ImageStack["lawLogoHome"] ?? SizedBox(),
              Container(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Text(TextContent["user"] as String),
              Row(
                children: [
                  Text(TextContent["level"].toString()),
                ],
              )
            ],
          ) //Text("This is a new screen for profile"),

      ));
    ;
  }
}
