import 'package:flutter/material.dart';

import '../pages/patient_info_page.dart';

class PatientTile extends StatefulWidget {
  PatientTile({
    super.key,
    required this.currentItem,
    required this.onClickEdit,
    required this.onClickDelete,
  });

  Map currentItem;
  final Function onClickEdit;
  final Function onClickDelete;

  @override
  State<PatientTile> createState() => _PatientTileState();
}

class _PatientTileState extends State<PatientTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PatientInfoPage()),
      ),
      child: Card(
        color: Colors.green,
        margin: const EdgeInsets.all(10),
        elevation: 3,
        child: ListTile(
          title: Text(widget.currentItem['name']),
          subtitle: Text(widget.currentItem['phone'].toString()),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () => widget.onClickEdit(),
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () => widget.onClickDelete(),
                  icon: const Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
  }
}
