abstract class ICloudDataBase {
  Future<Map<String,dynamic>> get(String path, String id);
  Future put(String path, Map<String, dynamic> map);
}
