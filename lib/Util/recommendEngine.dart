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

} catch (e) {
  print("Error in recommend Engine - $e");
}
  return Lawyers;
}

//this wil run after click on seach bar
Future<List<Map<String,dynamic>>> SearchEngine(String query) async {

  List<Map<String,dynamic>> Lawyers = [];
  List<String> searchParts = query.split(RegExp(r'\s+')); // Split by any whitespace
  print(searchParts); // Output: [one, two]

  var result = await FirebaseManager.db.collection("Lawyers")
      .where("name.fname", isEqualTo: searchParts[0] as String);
  if (searchParts.length > 1) {
    result = await result.where("name.lname", isEqualTo: searchParts[1] as String);
  }
      await result.get().then(
        (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        Lawyers.add(docSnapshot.data());
      }
    },
    onError: (e) => print("Error completing: $e"),
  );
//print(Lawyers);
  return Lawyers;
}