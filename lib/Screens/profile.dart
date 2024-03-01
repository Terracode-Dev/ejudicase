import 'package:flutter/material.dart';
import '../Util/tools.dart';
import '../Util/resources.dart';
import '../main.dart';



Widget circularNetworkImage(String imageUrl, imgType imgtype) {
  return ClipOval(
    child: getImage(type : imgtype,sourcePath: imageUrl) //TODO : here give the custom paras
  );
}


class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var TextContent =  resultSheet[3];

    String name = TextContent?["name"];

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
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Divider(
                height: 20,
                thickness: 2,
                color: Colors.black,
              ),),

              Text(name),
              Row(
                children: [
                  Text("aaw"),
                ],
              )
            ],
          ) //Text("This is a new screen for profile"),

      ));
    ;
  }
}
