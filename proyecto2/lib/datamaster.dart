import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'Rutina.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DataManager {
  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/rlist.json';
  }

  Future<List<Rutina>> loadRoutines() async {
    try {
      String filePath = await _getFilePath();
      File file = File(filePath);

      if (await file.exists()) {
        String jsonString = await file.readAsString();
        List<dynamic> jsonData = json.decode(jsonString);

        List<Rutina> rutinas = jsonData.map((json) => Rutina.fromJson(json)).toList();
        return rutinas;
      } else {
        String jsonString = await rootBundle.loadString('assets/json/rlist.json');
        List<dynamic> jsonData = json.decode(jsonString);

        List<Rutina> rutinas = jsonData.map((json) => Rutina.fromJson(json)).toList();
        return rutinas;
      }
    } catch (e) {
      throw Exception('Error loading routines: $e');
    }
  }

  Future<void> saveRoutines(List<Rutina> rutinas) async {
    try {
      String filePath = await _getFilePath();
      File file = File(filePath);

      String jsonString = json.encode(rutinas.map((rutina) => rutina.toJson()).toList());
      await file.writeAsString(jsonString);
    } catch (e) {
      throw Exception('Error saving routines: $e');
    }
  }
}
