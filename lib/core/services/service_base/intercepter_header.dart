import 'package:http_interceptor/http_interceptor.dart';

class InterceptorHeader implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData? data}) async {
    data!.headers['content-type'] = 'application/json';
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData? data}) async => data!;
}
