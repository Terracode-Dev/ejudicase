import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class FirebaseManager {
  FirebaseManager() {
    _initializeFirebase();
  }

  // Private method to initialize Firebase
  Future<void> _initializeFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  // Method to add or update data
  Future<void> storeData(String collectionPath, String docId, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection(collectionPath).doc(docId).set(data, SetOptions(merge: true));
      print('Data stored/updated successfully');
    } catch (e) {
      print('Error storing/updating data: $e');
    }
  }

  // Method to retrieve data by document ID
  Future<DocumentSnapshot> retrieveData(String collectionPath, String docId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection(collectionPath).doc(docId).get();
      print('Data retrieved successfully');
      return documentSnapshot;
    } catch (e) {
      print('Error retrieving data: $e');
      rethrow;
    }
  }

  // Example method to retrieve all documents from a collection
  Future<QuerySnapshot> retrieveAllData(String collectionPath) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(collectionPath).get();
      print('All data retrieved successfully');
      return querySnapshot;
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
    db = Db(connectionString);
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

//Auth Manager
class AuthManager {
  final mongo.Db mongoDb;
  final FirebaseFirestore firestore;

  AuthManager({
    required this.mongoDb,
    required this.firestore,
  });

  Future<bool> mongoAuth(String urnm, String pass) async {
    try {
      var collection = mongoDb.collection('user');
      var user = await collection.findOne(mongo.where.eq('username', urnm));
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
      var collection = firestore.collection('user');
      var querySnapshot = await collection.where('username', isEqualTo: urnm).get();
      var user = querySnapshot.docs.first.data();
      if (user != null && BCrypt.checkpw(pass, user['password'])) {
        return true;
      }
      return false;
    } catch (e) {
      print('FirebaseAuth error: $e');
      return false;
    }
  }

  String hashPassword(String pass) {
    return BCrypt.hashpw(pass, BCrypt.gensalt());
  }

  Future<void> createUserInMongo(Map<String, dynamic> userDetails) async {
    userDetails['password'] = hashPassword(userDetails['password']);
    await mongoDb.collection('user').insert(userDetails);
  }

  Future<void> createUserInFirestore(Map<String, dynamic> userDetails) async {
    userDetails['password'] = hashPassword(userDetails['password']);
    await firestore.collection('user').add(userDetails);
  }
}


