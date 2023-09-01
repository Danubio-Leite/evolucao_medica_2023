import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class DataService {
  final _patientsBox = Hive.box('patients_box');

  List<Map<String, dynamic>> refreshItems() {
    final data = _patientsBox.keys.map((key) {
      final item = _patientsBox.get(key);
      return {
        "key": key,
        "name": item["name"],
        "phone": item['phone'],
        "cpf": item['cpf'],
        "leito": item['leito'],
        "evolucao": item['evolucao'],
        "exames": item['exames'],
        "hipotese": item['hipotese'],
        "informacoes": item['informacoes'],
        "parametros": item['parametros'],
        "prescricao": item['prescricao'],
      };
    }).toList();

    return data.reversed.toList();
  }

  //Create new item
  Future<void> createItem(Map<String, dynamic> newItem) async {
    await _patientsBox.add(newItem);
    refreshItems();
  }

  Future<void> updateItem(int itemKey, Map<String, dynamic> item) async {
    await _patientsBox.put(itemKey, item);
    refreshItems(); //Update the UI
  }

  Future<void> deleteItem(int itemKey, context) async {
    await _patientsBox.delete(itemKey);
    refreshItems();

    //Display a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Paciente excluido com sucesso!')));
  }
}
