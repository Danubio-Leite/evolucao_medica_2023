import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('contacts_box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Crud',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 26, 18, 187)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Hive Crud'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  List<Map<String, dynamic>> _items = [];

  final _contactsBox = Hive.box('contacts_box');
  @override
  void initState() {
    super.initState();
    _refreshItems(); // Load data when app starts
  }

  void _refreshItems() {
    final data = _contactsBox.keys.map((key) {
      final item = _contactsBox.get(key);
      return {"key": key, "name": item["name"], "phone": item['phone']};
    }).toList();

    setState(() {
      _items = data.reversed.toList();
      print(_items.length);
    });
  }

  //Create new item
  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _contactsBox.add(newItem);
    _refreshItems();
  }

  Future<void> _updateItem(int itemKey, Map<String, dynamic> item) async {
    await _contactsBox.put(itemKey, item);
    _refreshItems(); //Update the UI
  }

  Future<void> _deleteItem(int itemKey) async {
    await _contactsBox.delete(itemKey);
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
