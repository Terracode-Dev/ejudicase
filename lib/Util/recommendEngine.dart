import 'dart:ffi';
import '../Util/dbManager.dart';
import 'package:geolocator/geolocator.dart';

//this will run when home is laoded for the user...
Future<List<Map<String,dynamic>>> RecommendEngine() async {


  List<Map<String,dynamic>> Lawyers = [];

  await FirebaseManager.db.collection("Lawyers")
      .where("Location.Lattitude", isGreaterThan: userLocation.minLattitude)
      .where("Location.Lattitude", isLessThan: userLocation.maxLattitude)
      .where("Location.Longitude", isGreaterThan: userLocation.minLongitude)
      .where("Location.Longitude", isLessThan: userLocation.maxLongitude)
      .get().then(
        (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        Lawyers.add(docSnapshot.data());
      }
    },
    onError: (e) => print("Error completing: $e"),
  );
  print(Lawyers);
  return Lawyers;
}

//this wil run after click on seach bar
List<Map<String,dynamic>> SearchEngine(String query) {

  List<Map<String,dynamic>> Lawyers = [];

  //TODO : Get a list of lawyers and push to the Report list

  return Lawyers;
}