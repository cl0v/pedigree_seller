import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ICloudDataBase {
  Future<Map<String, dynamic>?> get(String path, String id);
  Future put(String path, Map<String, dynamic> map);
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAll(
      String path, String id, String whereField);
}
