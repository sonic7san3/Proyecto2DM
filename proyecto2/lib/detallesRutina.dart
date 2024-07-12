import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'Juego.dart'; 
import 'Rutina.dart'; 

class DetallesRutina extends StatefulWidget {
  final Juego juego;

  const DetallesRutina({Key? key, required this.juego}) : super(key: key);

  @override
  _DetallesRutinaState createState() => _DetallesRutinaState();
}

class _DetallesRutinaState extends State<DetallesRutina> {
  late Future<List<Rutina>> futureRutinas;

  @override
  void initState() {
    super.initState();
    futureRutinas = loadRoutines();
  }

  Future<List<Rutina>> loadRoutines() async {
    try {
      final String response = await rootBundle.loadString('assets/json/rlist.json');
      final List<dynamic> data = jsonDecode(response);
      return data.map((json) => Rutina.fromJson(json)).toList();
    } catch (e) {
      print('Error parsing JSON: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.juego.nombre),
        backgroundColor: Color.fromARGB(255, 2, 2, 145),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              color: Color.fromRGBO(40, 40, 40, 1),
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre: ${widget.juego.nombre}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Genero: ${widget.juego.genero}',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Plataformas: ${widget.juego.plataformas.join(", ")}',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Descripcion: ${widget.juego.descripcion}',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Pagina web: ${widget.juego.webpage}',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Calificacion: ${widget.juego.calificacion}',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}