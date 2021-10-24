import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:appdogs/Models/response.dart';
import 'package:appdogs/Models/breed.dart';
import 'package:appdogs/Models/imagedog.dart';
import 'package:appdogs/components/loader_component.dart';
import 'package:appdogs/helpers/api_helper.dart';
import 'package:appdogs/screens/breed_detail_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class Breed_Screens extends StatefulWidget {

  @override
  _Breed_ScreensState createState() => _Breed_ScreensState();
}

class _Breed_ScreensState extends State<Breed_Screens> {
 List<Breed> _breeds = [];
  bool _showLoader = false;
  bool _isFiltered = false;
  String _search = '';

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
        actions: <Widget>[
          _isFiltered
          ? IconButton(
              onPressed: _removeFilter,
              icon: Icon(Icons.filter_none)
            ) : IconButton(
              onPressed: _showFilter,
              icon: Icon(Icons.filter_alt)
            )
        ],
      ),
      body: Center(
        child: _showLoader ? LoaderComponent(text: 'Por favor espere...') : _getContent(),
      ),   
    );
  }
   Future<Null> _getBreeds() async {
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

    Response response = await ApiHelper.getBreeds();

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
      _breeds = response.result;
    });
  }

  Widget _getContent() {
    return _breeds.length == 0 
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
      onRefresh: _getBreeds,
      child: ListView(
        children: _breeds.map((e) {
          return Card(
            child: InkWell(
              onTap: () => _goBreedImage(e),
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.breed, 
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios),
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

void _goBreedImage(Breed breed) async {
    String? result = await Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => BreedDetail_Screen(
          breed : breed
        )
      )
    );
    if (result == 'yes') {
     // _getUsers();
    }
  }
  
  void _showFilter() {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text('Filtrar Razas'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Escriba las primeras letras de la Raza'),
              SizedBox(height: 10,),
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Criterio de búsqueda...',
                  labelText: 'Buscar',
                  suffixIcon: Icon(Icons.search)
                ),
                onChanged: (value) {
                  _search = value;
                },
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: Text('Cancelar')
            ),
            TextButton(
              onPressed: () => _filter(), 
              child: Text('Filtrar')
            ),
          ],
        );
      });
  }

  void _removeFilter() {
    setState(() {
      _isFiltered = false;
    });
    _getBreeds();
  }

  void _filter() {
    if (_search.isEmpty) {
      return;
    }

    List<Breed> filteredList = [];
    for (var breeds in _breeds) {
       if (breeds.breed.toLowerCase().contains(_search.toLowerCase())) {
        filteredList.add(breeds);
      }
    }

    setState(() {
      _breeds = filteredList;
      _isFiltered = true;
    });

    Navigator.of(context).pop();
  }

  void _goAdd() async {
    String? result = await Navigator.push(
      context, ()
    );
    if (result == 'yes') {
      _getBreeds();
    }
  }
  void _goEdit(Breed breeds) async {
    String? result = await Navigator.push(
      context, 
      ( 
      )
    );
    if (result == 'yes') {
      _getBreeds();
    }
  }

   }
  
 


