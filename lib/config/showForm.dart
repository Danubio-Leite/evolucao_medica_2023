import 'package:flutter/material.dart';

import '../pages/patient_form_page.dart';

class ShowForm {
  List<Map<String, dynamic>> _items = [];

  void showForm(BuildContext ctx, int? itemKey) async {
    var existingItem;
    if (itemKey != null) {
      existingItem = _items.firstWhere((element) => element['key'] == itemKey);
    } //Verifica se o item já existe e preenche o modal com seus dados

    showModalBottomSheet(
      context: ctx,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => ModalPatient(
        itemKey: itemKey,
        name: existingItem != null ? existingItem['name'] : '',
        phone: existingItem != null ? existingItem['phone'] : '',
        cpf: '',
        evolucao: '',
        exames: '',
        hipotese: '',
        informacoes: '',
        leito: '',
        parametros: '',
        prescricao: '',

        /*
        cpf: existingItem != null ? existingItem['cpf'] : '',
        evolucao: existingItem != null ? existingItem['evolucao'] : '',
        exames: existingItem != null ? existingItem['exames'] : '',
        hipotese: existingItem != null ? existingItem['hipotese'] : '',
        informacoes: existingItem != null ? existingItem['informacoes'] : '',
        leito: existingItem != null ? existingItem['leito'] : '',
        parametros: existingItem != null ? existingItem['parametros'] : '',
        prescricao: existingItem != null ? existingItem['prescricao'] : '',*/
      ),
    );
  }
}
