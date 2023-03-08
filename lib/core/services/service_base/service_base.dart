import 'dart:async' show Future;
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_http.dart';
import 'package:xspace/core/services/service_base/intercepter_header.dart';
import 'package:xspace/resources/strings.dart';

//service base class along with all the required methods & base url of all the end-points services will be mentioned here.
class ServiceBase {
  static String apiBaseUrl =
      'https://api.spacexdata.com/v4/'; //production base url
  static Future<http.Response> get({
    String? url,
    String? baseUrl = '',
    required Map<String, String> headers,
  }) async {
    var netWorkStatus = await checkConnectionStatus();
    if (netWorkStatus) {
      String apiUrl = (baseUrl!.isEmpty ? apiBaseUrl : baseUrl) + url!;

      final response =
          await InterceptedHttp.build(interceptors: [InterceptorHeader()])
              .get(Uri.parse(apiUrl), headers: headers);

      return response;
    }
    throw Strings.noInternetAlert;
  }

  static Future<http.Response> post({
    String? url,
    required Map data,
    String baseUrl = '',
    required Map<String, String> headers,
  }) async {
    var netWorkStatus = await checkConnectionStatus();
    if (netWorkStatus) {
      String apiUrl = apiBaseUrl + url!;
      final response = await InterceptedHttp.build(
              interceptors: [InterceptorHeader()])
          .post(Uri.parse(apiUrl), body: jsonEncode(data), headers: headers);
      return response;
    }
    throw Strings.noInternetAlert;
  }
}

checkConnectionStatus() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}
