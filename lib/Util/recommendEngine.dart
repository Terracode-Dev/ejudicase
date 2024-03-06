import 'dart:ffi';
import '../Util/dbManager.dart';
import 'package:geolocator/geolocator.dart';

//this will run when home is laoded for the user...
Future<List<Map<String,dynamic>>> RecommendEngine() async {

  List<Map<String,dynamic>> Lawyers = [];
try {
  await FirebaseManager.db.collection("Lawyers")
      .where("Location.Lattitude", isGreaterThan: userLocation.minLattitude)
      .where("Location.Lattitude", isLessThan: userLocation.maxLattitude)
      .get().then(
        (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        var doc = docSnapshot.data();
        if (doc["Location"]["Longitude"] > userLocation.minLongitude && doc["Location"]["Longitude"] < userLocation.maxLongitude)
        {Lawyers.add(docSnapshot.data());} else {
          continue;
        }
      }
    },
    onError: (e) => print("Error completing: $e"),
  );

  //print(Lawyers);

} catch (e) {

  print("Error in recommend Engine - $e");
}
  return Lawyers;
}

//this wil run after click on seach bar
List<Map<String,dynamic>> SearchEngine(String query) {

  List<Map<String,dynamic>> Lawyers = [];

  //TODO : Get a list of lawyers and push to the Report list

  return Lawyers;
}