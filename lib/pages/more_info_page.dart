import 'package:evolucao_medica_2023/components/custom_white_buttom.dart';
import 'package:evolucao_medica_2023/pages/show_exame_page.dart';
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
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
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
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomWhiteButton(
                label: 'Voltar',
                onpressed: () {
                  Navigator.pop(context);
                }),
            CustomWhiteButton(
                label: 'Exames',
                onpressed: () {
                  if (widget.currentItem['exames'].toString() != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowExamePage(
                                currentItem: widget.currentItem,
                              )),
                    );
                  } else {
                    const AlertDialog(
                      content: Text('Paciente sem Exames'),
                    );
                  }
                }),
          ],
        ),
      ],
    );
  }
}
