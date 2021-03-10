import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:captain_bonik_app/common/utils/post_request_response.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'app.dart';

class Server{

  //new Url -> api.bacbonschool.com
  // static String get host => "http://api-test.bacbonschool.com/";
  static String get host => "https://api.bacbonschool.com/"; //TODO must check it enabled before release
  static String get videoBaseUrl =>"https://api.bacbonschool.com/api/getVideo/";
  static String explainImgBaseUrl = "https://api.bacbonschool.com/uploads/question_explanation/";
  static Server _s;
  var client;

  Server._(){
    client = new http.Client();
  }
  static Server get instance {
    if(_s != null)
      return _s;
    else
      _s = Server._();
    return _s;
  }

    Future<PostRequestResponse> postRequest({@required String url, @required Map postedData, String token,}) async {
    try {
      var body = json.encode(postedData);
      var response = await http.Client().post(
        Uri.encodeFull(host + url),
        headers: {"Content-Type": "application/json", "Authorization": "bearer ${token??App.serverToken}"},
        body: body,
      );
      var jsonData = jsonDecode(response.body);
      return PostRequestResponse.fromJson(jsonData);
    }
    on SocketException catch(_){
      return Future.error("No internet connection !");
    }
    on Exception catch(_)
    {
      return Future.error("Something error occurred !");
    }
  }

  Future<dynamic> getRequest({@required String url,token}) async {
    try {
      client.close();
      var response = await http.get(
          Uri.encodeFull(host + url),
          headers: {"Accept": "application/json", "Content-Type":"application/json", "Authorization": "bearer ${token??App.serverToken}"}
      );

      return jsonDecode(response.body);
    }
    on SocketException catch(_){
      return Future.error("internet",StackTrace.fromString("No internet connection !"));
    }
    on Exception catch(_)
    {
      return Future.error("others",StackTrace.fromString("Something error occurred !"));
    }
  }
}