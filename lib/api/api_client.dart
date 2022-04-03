import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tm_demo/api/api_constants.dart';
import 'package:tm_demo/base/base_resource.dart';
import 'package:tm_demo/base/response_parser.dart';

class ApiClient {
  String apiKey;

  ApiClient(this.apiKey);

  Future<Resource<T>> get<T>(String api) async {
    try {
      var res = await getResponse(api);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        var decodeRes = jsonDecode(res.body);
        return Resource<T>(
            model: ResponseParser.fromJson<T>(decodeRes as Map<String, dynamic>),
            message: "Success",
            status: ResourceStatus.success);
      } else {
        return Resource<T>(
            message: "Failed to load", status: ResourceStatus.failed);
      }
    } catch (ex) {
      print(ex);
    }
    return Resource<T>(message: "Network error", status: ResourceStatus.failed);
  }

  // Future<Resource<List<T>>> getList<T>(String api) async {
  //   try {
  //     var res = await getResponse(api);
  //     if (res.statusCode >= 200 && res.statusCode < 300) {
  //       var decodeRes = jsonDecode(res.body);
  //       return Resource<List<T>>(
  //           model: ResponseParser.fromList(decodeRes as List),
  //           message: "Success",
  //           status: ResourceStatus.success);
  //     } else {
  //       return Resource<List<T>>(
  //           message: "Failed to load", status: ResourceStatus.failed);
  //     }
  //   } catch (ex) {
  //     print(ex);
  //   }
  //   return Resource<List<T>>(
  //       message: "Network error", status: ResourceStatus.failed);
  // }

  Future<http.Response> getResponse(String api) async {
    if (api.contains("?")) {
      api = "$api&api_key=$apiKey&include_adult=false";
    } else {
      api = "$api?api_key=$apiKey&include_adult=false";
    }
    Uri uri = Uri.parse(TMDB_API_BASE_URL + api);
    var res=await http.get(uri);
    return res;
  }
}
