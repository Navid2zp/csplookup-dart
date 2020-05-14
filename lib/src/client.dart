import 'result.dart';
import 'package:http/http.dart';
import 'dart:convert';

const String API_BASE_URL = "lookup.configserver.pro/api/v1";
const String API_IP_LOOKUP_ENDPOINT = "/lookup/ip?ip=";

class LookupClient {
  String apiKey;
  bool _https = true;
  Duration _timeout = Duration(seconds: 10);

  LookupClient({this.apiKey});

  void setHttps(bool active) {
    this._https = active;
  }

  void setTimeout(Duration duration) {
    this._timeout = duration;
  }

  Future<LookupResponse> ipLookup(String ip) async {
    final String url = (this._https ? 'https://' : 'http://') + API_BASE_URL + API_IP_LOOKUP_ENDPOINT + ip;
    Map<String, String> headers = {'apiKey': this.apiKey};
    Response response =
        await get(url, headers: headers).catchError((error) => throw error).timeout(this._timeout);

    return new LookupResponse.fromJson(json.decode(response.body));
  }
}
