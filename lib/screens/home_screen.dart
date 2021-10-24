import 'package:appdogs/screens/breed_screens.dart';
import 'package:flutter/material.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({ Key? key }) : super(key: key);

  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children:<Widget> [
             _showLogo(),
             SizedBox(height: 20,),
              _showButtons(),
           ],

        ) ,)
    );
  }

  Widget  _showLogo() {
     return Image(
       image: AssetImage('assets/perros.jpg'),
       width: 300,
       );
  }

  Widget _showButtons() {
  return Container(
    margin: EdgeInsets.only(left: 10, right: 10),
    child: Row(
      
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
           child: ElevatedButton(
          child: Text('Ver razas'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return Colors.orange;
              }
        ),
      ),
          onPressed: () => _goBreedScreens(),
    ),
  ),
        SizedBox(width: 20,),

      ],
    ),
  );
}
void _goBreedScreens() async {
    String? result = await Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => Breed_Screens()
      )
    );
    if (result == 'yes') {
      _goBreedScreens();
    }
  }
}