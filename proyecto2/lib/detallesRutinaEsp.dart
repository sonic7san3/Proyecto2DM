import 'package:flutter/material.dart';
import 'Rutina.dart';

class detallesRutinaEsp extends StatefulWidget {
  final Rutina rutina;
  final Function(bool) callback;

  detallesRutinaEsp({required this.rutina, required this.callback});

  @override
  _detallesRutinaEspState createState() => _detallesRutinaEspState();
}

class _detallesRutinaEspState extends State<detallesRutinaEsp> {
  void _toggleTareaStatus(int index) {
    setState(() {
      widget.rutina.tareas[index].toggleStatus();
      _completeTareasStatus();
    });
  }

  void _completeTareasStatus() {
    bool allCompleted = widget.rutina.tareas.every((tarea) => tarea.status);
    if (allCompleted) {
      widget.callback(true);
      print("¡Todas las tareas están completadas!");
    } else {
      widget.callback(false);
      print("Aún hay tareas pendientes.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Rutina'),
        backgroundColor: Color.fromARGB(255, 2, 2, 145),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        widget.rutina.nombreRutina,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 12),
                      Text('Dificultad: ${widget.rutina.dificultad}', style: TextStyle(color: Colors.white70)),
                      SizedBox(height: 12),
                      Text('Descripcion: ${widget.rutina.descripcion}', style: TextStyle(color: Colors.white70)),
                      SizedBox(height: 12),
                      Text('Objetivo: ${widget.rutina.objetivo}', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Tareas:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(255, 137, 181, 239)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(widget.rutina.tareas.length, (index) {
                  var tarea = widget.rutina.tareas[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(tarea.nombre, style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.87))),
                      subtitle: Text(tarea.tarea, style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.60))),
                      trailing: InkWell(
                        onTap: () => _toggleTareaStatus(index),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: tarea.status ? const Color.fromARGB(255, 1, 123, 5) : Color.fromARGB(255, 208, 15, 1),
                          ),
                          child: Icon(
                            tarea.status ? Icons.check : Icons.cancel,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}