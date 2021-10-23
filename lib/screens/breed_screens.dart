import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:appdogs/Models/Response.dart';
import 'package:appdogs/Models/breed.dart';
import 'package:appdogs/components/loader_component.dart';
import 'package:appdogs/helpers/api_helper.dart';
import 'package:flutter/material.dart';

class Breed_Screens extends StatefulWidget {

  @override
  _Breed_ScreensState createState() => _Breed_ScreensState();
}

class _Breed_ScreensState extends State<Breed_Screens> {
  List<Breeds> _breeds = [];
   bool _showLoader = false;
   
  @override
  void initState() {
    super.initState();
    _getBreeds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Razas'),
      ),
      body: Center(
        child: Text('Razas'),
      ),
      
    );
  }

 
  void  _getBreeds () async {
   setState(() {
     _showLoader = true;
   });
    Response response = await ApiHelper.getBreeds();
    
    setState(() {
       _showLoader = false;
    });
  if(!response.isSuccess){
     await showAlertDialog(
        context: context,
        title: 'Error', 
        message: response.message,
        actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
        ]
      ); 
      return;
  }
  setState(() {
    _breeds = response.result;
  });
  }

  Widget _getListView() {
    return ListView(
      children: _breeds.map((e){
        return InkWell(
          child: Container(
            child: Text(e.message.toJson().toString()),

          ),
        );
      } 
      ).toList(),
    ); 
  }   
}

