import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bcrypt/bcrypt.dart';
import '../firebase_options.dart';
import 'package:mongo_dart/mongo_dart.dart';

//----------- single object to use thrugout
final FirebaseManager fbAdmin = FirebaseManager();
final AuthManager authAdmin = AuthManager(fbStore : FirebaseManager.db);

String hashPassword(String pass) {
  return BCrypt.hashpw(pass, BCrypt.gensalt());
}

class FirebaseManager {

  static FirebaseFirestore db = FirebaseFirestore.instance; //initial intializing with empty instanc e

  Future<void> initializeFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    db = FirebaseFirestore.instance;
  }

  Future<int> getDocCount(String collectionName) async {
    try {
      QuerySnapshot querySnapshot = await db.collection(collectionName).get();
      int count = querySnapshot.docs.length;
      return count;
    } catch (e) {
      print('Error getting document count: $e');
      return 0; // Return 0 or consider rethrowing the exception depending on your error handling strategy
    }
  }
  // Method to add or update data
  Future<void> storeData(String collection, Map<String, dynamic> data) async {
    try {
      data["id"] = await getDocCount(collection) + 1;
      DocumentReference docRef = await db.collection(collection).add(data);
      print('Data stored/updated successfully');
    } catch (e) {
      print('Error storing/updating data: $e');
    }
  }

  // Method to retrieve data by document ID
  Future<DocumentSnapshot> retrieveData(String collectionPath, String docId) async {
    try {
      DocumentSnapshot documentSnapshot = await db.collection(collectionPath).doc(docId).get();
      print('Data retrieved successfully');
      return documentSnapshot;
    } catch (e) {
      print('Error retrieving data: $e');
      rethrow;
    }
  }

  // Example method to retrieve all documents from a collection
  Future<Map<int, Map<dynamic, dynamic>>> retrieveAllData(String collectionPath) async {
    try {
      QuerySnapshot<Object?> querySnapshot = await db.collection(collectionPath).get();
      Map<int, Map<dynamic, dynamic>> data = {};
      print('All data retrieved successfully');
      for (var doc in querySnapshot.docs) {
        print(doc.data()); //TODO: doc sata serialization error... fix it

        Map<dynamic, dynamic> recievedData = doc.data() as Map<dynamic, dynamic>;
        //print(recievedData["id"]);
        data[recievedData["id"]] = recievedData; // output -> map ekk (1)
      }
      return data;
    } catch (e) {
      print('Error retrieving all data: $e');
      rethrow;
    }
  }
}


//Mongo Manager here
class MongoManager {
  late Db db;
  String connectionString = 'mongodb://yourMongoDBUri';

  MongoManager() {
    connect();
  }

  // Method to initialize MongoDB connection
  Future<void> connect() async {
    var db = Db(connectionString);
    await db.open();
    print('MongoDB connected');
  }

  // Method to store or update data in a collection
  Future<void> storeData(String collectionName, Map<String, dynamic> data) async {
    var collection = db.collection(collectionName);
    await collection.save(data);
    print('Data stored/updated successfully');
  }

  // Method to retrieve data by document ID
  Future<Map<String, dynamic>?> retrieveData(String collectionName, dynamic id) async {
    var collection = db.collection(collectionName);
    final data = await collection.findOne(where.id(ObjectId.fromHexString(id)));
    print('Data retrieved successfully');
    return data;
  }

  // Example method to retrieve all documents from a collection
  Future<List<Map<String, dynamic>>> retrieveAllData(String collectionName) async {
    var collection = db.collection(collectionName);
    final allData = await collection.find().toList();
    print('All data retrieved successfully');
    return allData;
  }

  // Optional: Close MongoDB connection
  Future<void> closeConnection() async {
    await db.close();
    print('MongoDB connection closed');
  }
}

//Auth Manager [Mongo and FireStore] TODO: use this.methods inside
class AuthManager {
  final Db? mongoDb;
  final FirebaseFirestore? firestore;

  AuthManager({Db? mongo, FirebaseFirestore? fbStore})
      : mongoDb = mongo,
        firestore = fbStore;

  Future<bool> mongoAuth(String urnm, String pass) async {
    try {
      DbCollection? collection = mongoDb?.collection('user');
      var user = await collection?.findOne(where.eq('username', urnm));
      if (user != null && BCrypt.checkpw(pass, user['password'])) {
        return true;
      }
      return false;
    } catch (e) {
      print('MongoAuth error: $e');
      return false;
    }
  }

  Future<bool> firebaseAuth(String urnm, String pass) async {
    try {
      CollectionReference<Map<String, dynamic>>? collection = firestore?.collection('user');
      var querySnapshot = await collection?.where('username', isEqualTo: urnm).get();
      var user = querySnapshot?.docs.first.data();
      if (user != null && BCrypt.checkpw(pass, user['password'])) {
        return true;
      }
      return false;
    } catch (e) {
      print('FirebaseAuth error: $e');
      return false;
    }
  }



  Future<void> createUserInMongo(Map<String, dynamic> userDetails) async {
    userDetails['password'] = hashPassword(userDetails['password']);
    await mongoDb?.collection('user').insert(userDetails);
  }

  Future<void> createUserInFirestore(Map<String, dynamic> userDetails) async {
    userDetails['password'] = hashPassword(userDetails['password']);
    await firestore?.collection('user').add(userDetails);
  }
}


