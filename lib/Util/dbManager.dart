import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bcrypt/bcrypt.dart';
import '../firebase_options.dart';
import 'package:mongo_dart/mongo_dart.dart';

//----------- single object to use thrugout after imports---------------
final FirebaseManager fbAdmin = FirebaseManager();
final AuthManager authAdmin = AuthManager();

//-----------Object Tools End--------------

String hashPassword(String pass) {
  return BCrypt.hashpw(pass, BCrypt.gensalt());
}


//------AUTH-----
//Auth Manager [Mongo and FireStore] TODO: use this.methods inside
class AuthManager {

  static FirebaseAuth fbAuth = FirebaseAuth.instance;

  Future<int> signInUser({required String emailAddr, required String Passwd }) async {
    try {
      final credential = await fbAuth.signInWithEmailAndPassword(
          email: emailAddr,
          password: Passwd
      );
      return 1;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return 0;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return -1;
      }
      return 0;

    }

  }

  Future<void> signOutUser () async {
    await fbAuth.signOut();
  }

  Future<void> createUser ({required String type , required String emailAddress ,required String password ,required Map<String, dynamic> dataSheet }) async {
    try {
      final credential = await fbAuth
          .createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      print("USER created");
      await fbAdmin.storeData(type, dataSheet, credential.user!.uid);
      print("user added and user details added to detail tables");


    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
//---- FIrebase methods------
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
  Future<void> storeData(String collection, Map<String, dynamic> data, String UID) async {
    try {
        db.collection(collection)
            .doc(UID)
            .set(data)
            .onError((e, _) => print("Error writing document: $e"));
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




