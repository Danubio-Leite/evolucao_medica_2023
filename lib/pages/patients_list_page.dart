import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PatientListPage extends StatefulWidget {
  const PatientListPage({super.key, required this.title});

  final String title;

  @override
  State<PatientListPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PatientListPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  List<Map<String, dynamic>> _items = [];

  final _patientsBox = Hive.box('patients_box');
  @override
  void initState() {
    super.initState();
    _refreshItems(); // Load data when app starts
  }

  void _refreshItems() {
    final data = _patientsBox.keys.map((key) {
      final item = _patientsBox.get(key);
      return {"key": key, "name": item["name"], "phone": item['phone']};
    }).toList();

    setState(() {
      _items = data.reversed.toList();
    });
  }

  //Create new item
  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _patientsBox.add(newItem);
    _refreshItems();
  }

  Future<void> _updateItem(int itemKey, Map<String, dynamic> item) async {
    await _patientsBox.put(itemKey, item);
    _refreshItems(); //Update the UI
  }

  Future<void> _deleteItem(int itemKey) async {
    await _patientsBox.delete(itemKey);
    _refreshItems();

    //Display a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An item has benn deleted')));
  }

  void _showForm(BuildContext ctx, int? itemKey) async {
    if (itemKey != null) {
      final existingItem =
          _items.firstWhere((element) => element['key'] == itemKey);
      _nameController.text = existingItem['name'];
      _phoneController.text = existingItem['phone'];
    } //Verifica se o item já existe e preenche o modal com seus dados

    showModalBottomSheet(
        context: ctx,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(ctx).viewInsets.bottom,
                  top: 15,
                  left: 15,
                  right: 15),
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
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () async {
                        if (itemKey == null) {
                          _createItem({
                            "name": _nameController.text,
                            "phone": _phoneController.text,
                          });
                        }

                        if (itemKey != null) {
                          _updateItem(itemKey, {
                            'name': _nameController.text.trim(),
                            'phone': _phoneController.text.trim(),
                          });
                        }

                        //Clear the text fields
                        _nameController.text = '';
                        _phoneController.text = '';

                        Navigator.of(context).pop();
                      },
                      child: Text(itemKey == null ? 'Create New' : 'Update')),
                  const SizedBox(height: 40),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 196, 194, 194),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (_, index) {
              final currentItem = _items[index];
              return Card(
                color: Colors.green,
                margin: const EdgeInsets.all(10),
                elevation: 3,
                child: ListTile(
                  title: Text(currentItem['name']),
                  subtitle: Text(currentItem['phone'].toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () =>
                              _showForm(context, currentItem['key']),
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () => _deleteItem(currentItem['key']),
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showForm(context, null),
          child: const Icon(Icons.add),
        ));
  }
}
