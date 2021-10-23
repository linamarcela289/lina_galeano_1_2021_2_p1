
import 'dart:convert';

import 'package:appdogs/Models/Response.dart';
import 'package:appdogs/Models/breed.dart';
import 'package:http/http.dart' as http;

import 'constans.dart';

class ApiHelper {

 static Future<Response> getBreeds() async {
    
       var url = Uri.parse('${Constans.apiUrl}');
       var response = await http.get(
      url,
      headers: {
        'content-type' : 'application/json',
        'accept' : 'application/json',
      },
    );

  var body = response.body;
  if(response.statusCode >= 400){
    return Response(isSuccess : false, message: body);
  }
 
  var decodeJson = jsonDecode(body);
 var list = decodeJson["message"];
  if(list != null){
   for(var item in list){
     list.add(Breeds.fromJson(item));
   }
  }
  return Response(isSuccess : true , result: list);
}
}