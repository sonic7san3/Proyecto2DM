import 'dart:convert';

class Tarea {
  String nombre;
  String tarea;
  bool status;

  Tarea(this.nombre, this.tarea, this.status);

  factory Tarea.fromJson(Map<String, dynamic> json) {
    return Tarea(
      json['nombre'],
      json['tarea'],
      json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'tarea': tarea,
      'status': status,
    };
  }
  
  void toggleStatus() {
    status = !status;
  }
}

class Rutina {
  int id;
  String nombreJuego;
  String nombreRutina;
  String dificultad;
  String descripcion;
  String objetivo;
  List<Tarea> tareas;
  bool completado;

  Rutina(
    this.id,
    this.nombreJuego,
    this.nombreRutina,
    this.dificultad,
    this.descripcion,
    this.objetivo,
    this.tareas,
    this.completado,
  );

  factory Rutina.fromJson(Map<String, dynamic> json) {
    var list = json['tareas'] as List;
    List<Tarea> tareaList = list.map((e) => Tarea.fromJson(e)).toList();

    return Rutina(
      json['id'],
      json['nombreJuego'],
      json['nombreRutina'],
      json['dificultad'],
      json['descripcion'],
      json['objetivo'],
      tareaList,
      json['completado'],
    );
  }

  bool todasTareasCompletas() {
    print("Todo listo");
    return tareas.every((tarea) => tarea.status);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombreJuego': nombreJuego,
      'nombreRutina': nombreRutina,
      'dificultad': dificultad,
      'descripcion': descripcion,
      'objetivo': objetivo,
      'tareas': tareas.map((tarea) => tarea.toJson()).toList(),
      'completado': todasTareasCompletas(),
    };
  }
}
