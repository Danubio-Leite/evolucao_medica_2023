import 'package:evolucao_medica_2023/image_picker/exame_page_picker.dart';
import 'package:flutter/material.dart';

import '../config/data_service.dart';

class PatientForm extends StatefulWidget {
  PatientForm({
    super.key,
    required this.itemKey,
    required this.name,
    required this.phone,
    required this.leito,
    required this.cpf,
    required this.prescricao,
    required this.hipotese,
    required this.evolucao,
    required this.parametros,
    this.exames = const [],
    required this.informacoes,
  });

  var itemKey; //Era int e estava dando erro, alterei para var
  String name;
  String phone;
  String leito;
  String cpf;
  String prescricao;
  String hipotese;
  String evolucao;
  String parametros;
  //transformei o exames em list
  List<String> exames;
  String informacoes;

  @override
  State<PatientForm> createState() => _ModalPatientState();
}

class _ModalPatientState extends State<PatientForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _evolucaoController = TextEditingController();
  final TextEditingController _examesController = TextEditingController();
  final TextEditingController _hipoteseController = TextEditingController();
  final TextEditingController _informacoesController = TextEditingController();
  final TextEditingController _leitoController = TextEditingController();
  final TextEditingController _parametrosController = TextEditingController();
  final TextEditingController _prescricaoController = TextEditingController();

  List<String>? exames;

  DataService dataService = DataService();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _phoneController.text = widget.phone;
    _cpfController.text = widget.cpf;
    _evolucaoController.text = widget.evolucao;
    exames = widget.exames;
    _hipoteseController.text = widget.hipotese;
    _informacoesController.text = widget.informacoes;
    _leitoController.text = widget.leito;
    _parametrosController.text = widget.parametros;
    _prescricaoController.text = widget.prescricao;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Cadastro de Paciente'),
      ),
      body: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 15,
            left: 15,
            right: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Phone'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _cpfController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'CPF'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _evolucaoController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Evolução',
                  hintStyle: TextStyle(
                      leadingDistribution: TextLeadingDistribution.even),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 5,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _hipoteseController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(hintText: 'Hipotese'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _informacoesController,
                keyboardType: TextInputType.text,
                decoration:
                    const InputDecoration(hintText: 'Informacões adicionais'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _leitoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Leito'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _parametrosController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(hintText: 'Paramêtros'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _prescricaoController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(hintText: 'Prescrição'),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      side: const BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () async {
                      var temp = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExamePagePicker(exames),
                        ),
                      );
                      if (temp != null) {
                        exames?.addAll(temp);
                      }
                    },
                    child: const Text(
                      'Anexar Exames',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    )),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  print(exames);
                  setState(() {
                    if (widget.itemKey == null) {
                      dataService.createItem({
                        "name": _nameController.text,
                        "phone": _phoneController.text,
                        "cpf": _cpfController.text,
                        "evolucao": _evolucaoController.text,
                        "exames": exames,
                        "hipotese": _hipoteseController.text,
                        "informacoes": _informacoesController.text,
                        "leito": _leitoController.text,
                        "parametros": _parametrosController.text,
                        "prescricao": _prescricaoController.text,
                      });
                    }

                    if (widget.itemKey != null) {
                      dataService.updateItem(widget.itemKey, {
                        'name': _nameController.text.trim(),
                        'phone': _phoneController.text.trim(),
                        "cpf": _cpfController.text.trim(),
                        "evolucao": _evolucaoController.text.trim(),
                        "exames": exames,
                        "hipotese": _hipoteseController.text.trim(),
                        "informacoes": _informacoesController.text.trim(),
                        "leito": _leitoController.text.trim(),
                        "parametros": _parametrosController.text.trim(),
                        "prescricao": _prescricaoController.text.trim(),
                      });
                    }

                    //Clear the text fields
                    _nameController.text = '';
                    _phoneController.text = '';
                    _cpfController.text = '';
                    _evolucaoController.text = '';
                    _examesController.text = '';
                    _hipoteseController.text = '';
                    _informacoesController.text = '';
                    _leitoController.text = '';
                    _parametrosController.text = '';
                    _prescricaoController.text = '';

                    Navigator.of(context).pop(dataService.refreshItems());
                  });
                },
                child:
                    Text(widget.itemKey == null ? 'Salvar' : 'Atualizar Dados'),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
