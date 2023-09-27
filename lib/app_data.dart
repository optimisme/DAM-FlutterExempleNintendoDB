import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppData with ChangeNotifier {

  bool readyConsoles = false; 
  bool readyJocs = false;
  bool readyPersonatges = false;

  late dynamic dataConsoles;
  late dynamic dataJocs;
  late dynamic dataPersonatges;

  // Diu si les dades estàn llestes o no
  bool dataReady (String type) {
    switch (type) {
      case 'Consoles':    return readyConsoles;
      case 'Jocs':        return readyJocs;
      case 'Personatges': return readyPersonatges;
    }
    return false;
  }

  dynamic getData (String type) {
    switch (type) {
      case 'Consoles':    return dataConsoles;
      case 'Jocs':        return dataJocs;
      case 'Personatges': return dataPersonatges;
    }
    return;
  }

  // Tornar un item específic de l'array de dades
  dynamic getItemData (String type, int index) {
    if (dataReady(type)) {
      return getData(type)[index];
    }
    return;
  }

  // Escull quin arxiu cal llegir i en carrega les dades
  void load (String type) async {

    // Escollim l'arxiu d'on s'han de carregar les dades
    var arxiu = "";
    switch (type) {
      case 'Consoles':    arxiu = "assets/data/consoles.json"; break;
      case 'Jocs':        arxiu = "assets/data/jocs.json"; break;
      case 'Personatges': arxiu = "assets/data/personatges.json"; break;
    }

    // Forcem esperar 1 segon per veure el progrés
    await Future.delayed(const Duration(seconds: 1));

    // Carreguem les dades de l'arxiu
    var textArxiu = await rootBundle.loadString(arxiu);
    var dadesArxiu = json.decode(textArxiu);
    
    // Guardem les dades carregades
    switch (type) {
      case 'Consoles':    readyConsoles = true;    dataConsoles = dadesArxiu; break;
      case 'Jocs':        readyJocs = true;        dataJocs = dadesArxiu; break;
      case 'Personatges': readyPersonatges = true; dataPersonatges = dadesArxiu; break;
    }

    // Avisem que les dades estàn disponibles
    notifyListeners();
  }
}