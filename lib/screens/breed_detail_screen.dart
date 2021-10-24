import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:appdogs/Models/breed.dart';
import 'package:appdogs/Models/imagedog.dart';
import 'package:appdogs/Models/response.dart';
import 'package:appdogs/components/loader_component.dart';
import 'package:appdogs/helpers/api_helper.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class BreedDetail_Screen extends StatefulWidget {
  final Breed breed;

BreedDetail_Screen({required this.breed});

  @override
  _BreedDetail_ScreenState createState() => _BreedDetail_ScreenState();

}

class _BreedDetail_ScreenState extends State<BreedDetail_Screen> {
  
  List<BreedImages> _breedimages = [];
  List<Breed> _breeds = [];
 // Breed _breed = [];
  bool _showLoader = false;
  bool _isFiltered = false;
  String _search = '';

  @override
  void initState() {
    super.initState();
    _getBreedImage();
  }
   @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Imagenes'),
     
      ),
      body: Center(
        child: _showLoader ? LoaderComponent(text: 'Por favor espere...') : _getContent(),
      ),   
    );
  }
  
   Future<Null> _getBreedImage() async {
    setState(() {
      _showLoader = true;
    });
 var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _showLoader = false;
      });
      await showAlertDialog(
        context: context,
        title: 'Error', 
        message: 'Verifica que estes conectado a internet.',
        actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
        ]
      );    
      return;
    }

    Response response = await ApiHelper.getBreedImage(widget.breed.breed);

     setState(() {
      _showLoader = false;
    });

    if (!response.isSuccess) {
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
      _breedimages = response.result;
    });
  }

  Widget _getContent() {
    return _breedimages.length == 0 
      ? _noContent()
      : _getListView();
  }

   Widget _noContent() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Text(
          _isFiltered
          ? 'No hay razas con ese criterio de búsqueda.'
          : 'No hay razas registrados.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
  Widget _getListView() {
    return RefreshIndicator(
      onRefresh: _getBreedImage,
      child: ListView(
        children: _breedimages.map((e) {
          return Card(
            child: InkWell(
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.network(
                        e.image,
                        
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      ),

                    ),
                       // Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
  }
  
  
