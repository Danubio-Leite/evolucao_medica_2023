import 'package:flutter/material.dart';

import '../config/data_service.dart';

class ModalPatient extends StatefulWidget {
  ModalPatient(
      {super.key,
      required this.itemKey,
      required this.name,
      required this.phone});

  int itemKey;
  String name;
  String phone;

  @override
  State<ModalPatient> createState() => _ModalPatientState();
}

class _ModalPatientState extends State<ModalPatient> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  DataService dataService = DataService();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _phoneController.text = widget.phone;
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
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
                if (widget.itemKey == null) {
                  dataService.createItem({
                    "name": _nameController.text,
                    "phone": _phoneController.text,
                  });
                }

                if (widget.itemKey != null) {
                  dataService.updateItem(widget.itemKey, {
                    'name': _nameController.text.trim(),
                    'phone': _phoneController.text.trim(),
                  });
                }

                //Clear the text fields
                _nameController.text = '';
                _phoneController.text = '';

                Navigator.of(context).pop();
              },
              child: Text(widget.itemKey == null ? 'Create New' : 'Update')),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
