import 'package:flutter/material.dart';

class MoreInfoPage extends StatefulWidget {
  MoreInfoPage({super.key, required this.currentItem});
  Map currentItem;

  @override
  State<MoreInfoPage> createState() => _MoreInfoPageState();
}

class _MoreInfoPageState extends State<MoreInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            const Text(
              'Nome:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.currentItem['name'],
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              'Leito:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.currentItem['leito'].toString(),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              'CPF:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.currentItem['cpf'].toString(),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              'Telefone:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.currentItem['phone'].toString(),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              'Exames:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.currentItem['exames'].toString(),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              'Hipotese:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.currentItem['hipotese'].toString(),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              'Paramêtros:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.currentItem['parametros'].toString(),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
        Wrap(
          children: [
            const Text(
              'Prescrição:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.currentItem['prescricao'].toString(),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
        Wrap(
          children: [
            const Text(
              'Informações:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.currentItem['informacoes'].toString(),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Voltar',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
