import 'package:evolucao_medica_2023/components/patient_tile.dart';
import 'package:evolucao_medica_2023/pages/patient_form_page.dart';
import 'package:flutter/material.dart';
import '../config/data_service.dart';

class PatientListPage extends StatefulWidget {
  const PatientListPage({super.key, required this.title});

  final String title;

  @override
  State<PatientListPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PatientListPage> {
  List<Map<String, dynamic>> _items = [];

  DataService dataService = DataService();
  //@override
  void initState() {
    super.initState();
    _items = dataService.refreshItems(); // Load data when app starts
  }

  void showForm(BuildContext ctx, int? itemKey) async {
    var existingItem;
    if (itemKey != null) {
      existingItem = _items.firstWhere((element) => element['key'] == itemKey);
    } //Verifica se o item já existe e preenche o modal com seus dados
    var _itemstemp = await showModalBottomSheet(
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
    setState(() {
      _items = _itemstemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 196, 194, 194),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 86, 145, 88),
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (_, index) {
            final currentItem = _items[index];
            return PatientTile(
                currentItem: currentItem,
                onClickEdit: () {
                  showForm(context, currentItem['key']);
                },
                onClickDelete: () {
                  setState(() {
                    dataService
                        .deleteItem(currentItem['key'], context)
                        .then((_) => setState(() {
                              _items = dataService.refreshItems();
                            }));
                  });
                });
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () => showForm(context, null),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
