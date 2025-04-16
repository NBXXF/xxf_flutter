
import 'package:xxf_http/xxf_http.dart';

import '../model/data.dart';
import 'apis.dart';
part 'api_client.g.dart';
@RestApi(baseUrl: "https://gorest.co.in/public-api/")
@UserClientAdapter(client: MyClientAdapter)
///@UseCallAdapter(callAdapter:ResultCallAdapter)
abstract class ApiClient {
  factory ApiClient() {
    return _ApiClient(null);
  }

  @GET(Apis.users)
  Future<ResponseData> getUsers();
}
class MyClientAdapter extends ClientAdapter{
  @override
  Dio adapt() {
    // TODO: implement adapt
    throw UnimplementedError();
  }
}
// class ResultCallAdapter<T> extends CallAdapter<Future<T>, Future<Result<T>>> {
//   @override
//   Future<Result<T>> adapt(Future<T> Function() call) async {
//     try {
//       final response = await call();
//       return Success<T>(response);
//     } catch (e) {
//       return Error(e);
//     }
//   }
// }