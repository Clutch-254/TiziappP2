import 'package:cloud_firestore/cloud_firestore.dart';
import 'local_database.dart';

class DatabaseMethods {
  // Add item to local database
  Future addFitItem(Map<String, dynamic> userInfoMap, String category) async {
    // Ensure the map has the 'Category' field
    userInfoMap['Category'] = category;
    return await LocalDatabase.instance.insertItem(userInfoMap);
  }

  // Get items from local database (replacing stream with future for now, or we could emit stream)
  // The UI expects a Stream, so we can wrap the future in a stream or change UI.
  // For now, let's return a Stream to minimize UI changes, though it won't be "live" like Firestore without more work.
  Stream<QuerySnapshot> getFitItem(String category) async* {
    // This is a bit of a hack to keep the signature similar-ish, but QuerySnapshot is Firestore specific.
    // We should probably change the UI to expect List<Map> instead of QuerySnapshot.
    // However, to strictly follow "Refactor database.dart", let's change the return type to what makes sense for SQLite: Future<List<Map<String, dynamic>>>
    // But wait, the UI uses StreamBuilder.
    // Let's change this to return Future<List<Map<String, dynamic>>> and update UI later.
    throw UnimplementedError("Use getLocalItems instead");
  }

  Future<List<Map<String, dynamic>>> getLocalItems(String category) async {
    return await LocalDatabase.instance.getItems(category);
  }

  // Keeping these for reference but they should be replaced by getLocalItems
  Future<Stream<QuerySnapshot>> getSubItem(String name) async {
    return FirebaseFirestore.instance.collection(name).snapshots();
  }

  Future<Stream<QuerySnapshot>> getGymItem(String name) async {
     // This was used for Foods
     // We will use getLocalItems("Foods") instead in the UI
     throw UnimplementedError("Use getLocalItems instead");
  }
}