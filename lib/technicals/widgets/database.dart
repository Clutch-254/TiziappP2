import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  Future addFitItem(Map<String, dynamic> userInfoMap, String name) async{
    return await FirebaseFirestore.instance
    .collection(name)
    .add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getSubItem(String name)async{
    return await FirebaseFirestore.instance.collection(name).snapshots();

  }
  Future<Stream<QuerySnapshot>> getGymItem(String name)async{
    return await FirebaseFirestore.instance.collection(name).snapshots();

  }
  Future<Stream<QuerySnapshot>> getFitItem(String name)async{
    return await FirebaseFirestore.instance.collection(name).snapshots();

  }
}