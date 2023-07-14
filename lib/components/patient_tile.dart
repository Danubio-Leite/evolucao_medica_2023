import 'package:flutter/material.dart';

import '../config/data_service.dart';

class PatientTile extends StatefulWidget {
  const PatientTile({super.key});

  @override
  State<PatientTile> createState() => _PatientTileState();
}

class _PatientTileState extends State<PatientTile> {
  List<Map<String, dynamic>> _items = [];
  DataService dataService = DataService();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                      onPressed: () => showForm(context, currentItem['key']),
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          dataService
                              .deleteItem(currentItem['key'], context)
                              .then((_) => setState(() {
                                    //setstate
                                  }));
                        });
                      },
                      icon: const Icon(Icons.delete))
                ],
              ),
            ),
          );
        });
  }
}
