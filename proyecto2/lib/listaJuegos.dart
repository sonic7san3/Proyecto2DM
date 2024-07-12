import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
import 'Juego.dart'; 
import 'Rutina.dart'; 
import 'dart:convert' as convert;
import 'detallesRutina.dart';

Future<List<Juego>> loadGames() async {
  String jsonString = await rootBundle.loadString('assets/json/glist.json');
  List<dynamic> jsonData = convert.jsonDecode(jsonString);

  List<Juego> juegos = jsonData.map((json) => Juego.fromJson(json)).toList();
  return juegos;
}

class ListaJuegos extends StatelessWidget {
  const ListaJuegos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 2, 145),
        title: Text("Juegos"),
      ),
      body: Container(
        color: Color.fromARGB(255, 22, 127, 246),
        child: FutureBuilder<List<Juego>>(
          future: loadGames(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              List<Juego> juegos = snapshot.data!;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1, // Aspecto 1:1 para cuadrados
                ),
                padding: const EdgeInsets.all(10.0),
                itemCount: juegos.length,
                itemBuilder: (context, index) {
                  Juego Juegos = juegos[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetallesRutina(juego: Juegos),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 15, 179, 204),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          Juegos.icon,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('No data found'));
            }
          },
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

void main() {
  runApp(MaterialApp(
    home: ListaJuegos(),
  ));
}