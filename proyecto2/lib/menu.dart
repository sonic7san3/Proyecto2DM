import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert' as convert;
import 'Rutina.dart';
import 'perfilJugador.dart';
import 'listaJuegos.dart';
import 'detallesApp.dart';
import 'detallesRutinaEspecifica.dart';

Future<List<Rutina>> loadRoutines() async {
  String jsonString = await rootBundle.loadString('assets/json/rlist.json');
  List<dynamic> jsonData = convert.jsonDecode(jsonString);

  List<Rutina> rutinas = [];
  for (var data in jsonData) {
    String nombreJuego = data['nombreJuego'];
    List<dynamic> rutinasData = data['rutinas'];
    for (var rutinaData in rutinasData) {
      rutinas.add(Rutina.fromJson({
        'nombreJuego': nombreJuego,
        ...rutinaData,
      }));
    }
  }

  return rutinas;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Routine Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color.fromRGBO(30, 30, 30, 1),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white70),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 2, 2, 145),
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      home: Menu(),
    );
  }
}

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<Rutina> rutinas = []; ///// Lista para almacenar las rutinas

  @override
  void initState() {
    super.initState();
    loadRoutines().then((loadedRutinas) {
      setState(() {
        rutinas = loadedRutinas;
      });
    });
  }

  void updateRutinaCompletionStatus(bool allCompleted) {
    setState(() {
      for (var rutina in rutinas) {
        if (rutina.tareas.every((tarea) => tarea.status)) {
          rutina.completado = true;
        } else {
          rutina.completado = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String iconUser = "assets/icons/idusuario.svg";
    String iconController = "assets/icons/consolaswitch.svg";
    String iconDetails = "assets/icons/details.svg";

    return Scaffold(
      appBar: AppBar(
        title: Text("Sonic7san3"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 12, 2, 73),
              ),
              child: Column(
                children: [
                  
                  Text('Menu', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 24)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.white),
              title: Text('Inicio', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: SvgPicture.asset(iconUser, width: 45, height: 45),
              title: const Text('Perfil', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PerfilJugador()),
                );
              },
            ),
            ListTile(
              leading: SvgPicture.asset(iconController, width: 45, height: 45),
              title: const Text('Lista de juegos', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListaJuegos()),
                );
              },
            ),
            ListTile(
              leading: SvgPicture.asset(iconDetails, width: 45, height: 45),
              title: const Text('Detalles de la app', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DetallesApp()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: rutinas.length,
          itemBuilder: (context, index) {
            Rutina rutina = rutinas[index];
            return Card(
              color: Color.fromRGBO(40, 40, 40, 1),
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(rutina.nombreRutina, style: TextStyle(color: Colors.white)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Juego: ${rutina.nombreJuego}", style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 4),
                    Text("Dificultad: ${rutina.dificultad}", style: TextStyle(color: Colors.white70)),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetallesRutinaEspecifica(rutina: rutina, callback: updateRutinaCompletionStatus),
                    ),
                  );
                },
                trailing: rutina.completado
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : Icon(Icons.cancel, color: Colors.red),
              ),
            );
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