import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PerfilJugador extends StatelessWidget {
  const PerfilJugador({Key? key});

  @override
  Widget build(BuildContext context) {
    String iconUser = "assets/icons/pory.svg";
    String iconFavorite = "assets/icons/nintendo.svg";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 2, 145),
        title: Text("Perfil de usuario"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: <Widget>[
              SizedBox(height: 20), 

              Row(
                children: [
                  SvgPicture.asset(iconUser, height: 75, width: 75),
                  SizedBox(width: 10), 
                  Expanded( 
                    child: Text(
                      "Sonic7san3",
                      style: TextStyle(
                        fontFamily: "SonicFont",
                        fontSize: 20,
                        color: Color.fromRGBO(235, 235, 211, 1),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20), 

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Soy un amante de los videojuegos desde que tengo memoria, quiero llegar a ser mejor que la gente de renombre de ahora',
                  style: TextStyle(
                    fontFamily: 'SonicFont',
                    fontSize: 20,
                    color: Color.fromARGB(206, 12, 12, 249),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 40), // Espacio adicional 
            ],
          ),
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Regresar"),
        ),
      ],
    );
  }
}
