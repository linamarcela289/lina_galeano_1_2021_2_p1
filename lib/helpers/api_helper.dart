
import 'dart:convert';

import 'package:appdogs/Models/response.dart';
import 'package:appdogs/Models/breed.dart';
import 'package:appdogs/Models/imagedog.dart';
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
 
List<Breed> breeds =[];
Map map = await json.decode(body);
var data = map["message"];
for(String key in data.keys){
  if(key != ""){
    Breed breed = Breed(breed: key);
    breeds.add(breed);
  }
}
  return Response(isSuccess : true , result: breeds);
}

static Future<Response> getBreedImage( String breed) async {
    var url = Uri.parse("${Constans.apiUrlImage}$breed/images");

     //var url = Uri.parse("$baseUrl/breed/$name/images");
       //var url = Uri.parse('${Constans.apiUrl}/bouvier/images');
        var response = await http.get(
       url,
      );

  var body = response.body;
  if(response.statusCode >= 400){
    return Response(isSuccess : false, message: body);
  }
  List<BreedImages> breedimages =[];

  Map map = await json.decode(response.body);
      var data = map["message"];
      for (String? value in data) {
        if (value != null || value != "") {
          BreedImages breedImages = BreedImages(image: value!);
          breedimages.add(breedImages);
        }
    }
   return Response(isSuccess : true , result: breedimages);
 }


}

