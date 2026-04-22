abstract class DatabaseService {
  Future<dynamic> get(String endPoint, {Map<String, dynamic>? queryParameters});
  Future<dynamic> post(String endPoint, dynamic body);
  Future<dynamic> put(String endPoint, dynamic body);
  Future<dynamic> delete(String endPoint, dynamic body);

}
