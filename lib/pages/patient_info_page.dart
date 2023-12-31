import 'dart:io';

import 'package:evolucao_medica_2023/components/custom_white_buttom.dart';
import 'package:evolucao_medica_2023/pages/more_info_page.dart';
import 'package:evolucao_medica_2023/pages/pdf_view_page.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pdfLib;

class PatientInfoPage extends StatefulWidget {
  PatientInfoPage({super.key, required this.currentItem});
  Map currentItem;

  @override
  State<PatientInfoPage> createState() => _PatientInfoPageState();
}

class _PatientInfoPageState extends State<PatientInfoPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.currentItem['exames']);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/background.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color.fromARGB(86, 42, 136, 146),
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(
              top: 30,
              bottom: 15,
              left: 15,
              right: 15,
            ),
            height: double.infinity,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 1,
                  child: Row(
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
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      const Text(
                        'Leito:',
                        softWrap: true,
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
                ),
                Flexible(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Evolução:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            widget.currentItem['evolucao'],
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomWhiteButton(
                          label: 'Voltar',
                          onpressed: () {
                            Navigator.pop(context);
                          }),
                      Flexible(
                        flex: 1,
                        child: CustomWhiteButton(
                            label: 'Mais Informações',
                            onpressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      "Informações",
                                      textAlign: TextAlign.center,
                                    ),
                                    content: MoreInfoPage(
                                      currentItem: widget.currentItem,
                                    ),
                                  );
                                },
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomWhiteButton(
                      label: 'Exportar Dados',
                      onpressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "Exportação de Dados",
                                textAlign: TextAlign.center,
                              ),
                              content: SizedBox(
                                width: double.infinity,
                                height: 300,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomWhiteButton(
                                        label: 'Exportar em PDF',
                                        onpressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PDFViewPage(
                                                currentItem: widget.currentItem,
                                              ),
                                            ),
                                          );
                                        }),
                                    CustomWhiteButton(
                                        label: 'Exportar em Texto',
                                        onpressed: () {}),
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
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
