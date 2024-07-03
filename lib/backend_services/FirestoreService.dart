import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> isEmployer(String uid) async {
    try {
      final adminDoc = await _db.collection('roles').doc('employer').get();
      if (adminDoc.exists && adminDoc.data() != null && adminDoc.data()!.containsKey('employer')) {
        List<dynamic> adminUids = adminDoc['employer'];
        return adminUids.contains(uid);
      }
    } catch (e) {
      print("Error checking employer status: $e");
      return false;
    }
    return false;
  }

  Future<bool> isEmployee(String uid) async {
    try {
      final adminDoc = await _db.collection('roles').doc('employee').get();
      if (adminDoc.exists && adminDoc.data() != null && adminDoc.data()!.containsKey('employee')) {
        List<dynamic> adminUids = adminDoc['employee'];
        return adminUids.contains(uid);
      }
    } catch (e) {
      print("Error checking employee status: $e");
      return false;
    }
    return false;
  }

  Future<Map<String, bool>> checkRoles(String uid) async {
    final results = await Future.wait([
      isEmployer(uid),
      isEmployee(uid),
    ]);
    print(results);
    return {
      'isEmployer': results[0],
      'isEmployee': results[1],
    };
  }

  Future<bool> addUidToEmployer(String uid) async {
    try {
      await _db.collection('roles').doc('employer').set({
        'employer': FieldValue.arrayUnion([uid])
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      print("Error adding uid to employer array: $e");
      return false;
    }
  }

  Future<bool> addUidToEmployee(String uid) async {
    try {
      await _db.collection('roles').doc('employee').set({
        'employee': FieldValue.arrayUnion([uid])
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      print("Error adding uid to employee array: $e");
      return false;
    }
  }
}
