import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetallesApp extends StatelessWidget {
  const DetallesApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 2, 145),
        title: Text("Detalles"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Esta aplicacion es un proyecto universitario. Tiene como objetivo ayudar a la comunidad de gamers en la actualidad a mejorar sus habilidades en todo tipo de juegos.",
                    style: TextStyle(
                      fontFamily: "SonicFont",
                      fontSize: 23,
                      letterSpacing: 0.7,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
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
