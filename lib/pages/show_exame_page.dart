import 'package:evolucao_medica_2023/components/custom_white_buttom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../components/custom_async_button.dart';

class ShowExamePage extends StatefulWidget {
  //transformar map em objeto...
  Map currentItem;
  ShowExamePage({super.key, required this.currentItem});

  @override
  State<ShowExamePage> createState() => _ShowExamePageState();
}

class _ShowExamePageState extends State<ShowExamePage> {
  final PageController _pageController = PageController(initialPage: 0);

  int activePage = 0;
  List<String> _pages = [];
  final String imageAsset = 'assets/images/blue.png';

  @override
  void initState() {
    _pages = widget.currentItem['exames'];

    print('_pages.lenght é ${_pages.length}');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(136, 150, 200, 219),
        title: const Text('Exames'),
      ),
      body: Container(
        color: const Color.fromARGB(136, 150, 200, 219),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Flexible(
            flex: 5,
            child: Stack(
              children: [
                PageView.builder(
                  //2h para descobrir que faltava o controller
                  controller: _pageController,
                  scrollBehavior: const CupertinoScrollBehavior(),
                  itemCount: _pages != null ? _pages.length : 1,
                  pageSnapping: true,
                  onPageChanged: (page) {
                    setState(() {
                      activePage = page;
                    });
                  },
                  itemBuilder: (context, pagePosition) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: _pages[pagePosition] != null
                          ? InteractiveViewer(
                              child: Image.memory(
                                base64Decode(
                                  _pages[pagePosition].toString(),
                                ),
                              ),
                            )
                          : const Center(
                              child: Text('Paciente Sem Exames Cadastrados.'),
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                _pages.length,
                (index) => Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
                  child: InkWell(
                    onTap: () {
                      _pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                    child: CircleAvatar(
                      radius: 6,
                      backgroundColor:
                          activePage == index ? Colors.amber : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomWhiteButton(
                    label: 'Excluir',
                    onpressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              "Confirma a exclusão do Exame?",
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomWhiteButton(
                                      label: 'Voltar',
                                      onpressed: () {
                                        Navigator.pop(context);
                                      }),
                                  CustomWhiteButton(
                                      label: 'Excluir',
                                      onpressed: () {
                                        setState(() {
                                          _pages.removeAt(activePage);
                                        });

                                        Navigator.pop(context);
                                        print(_pages);
                                      }),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    }),
                Flexible(
                  flex: 1,
                  child: CustomAsyncButton(
                    label: 'Compartilhar',
                    onpressed: () async {
                      final image = base64Decode(
                        _pages[activePage].toString(),
                      );
                      final buffer = image.buffer;
                      Share.shareXFiles(
                        [
                          XFile.fromData(
                            buffer.asUint8List(
                              image.offsetInBytes,
                              image.lengthInBytes,
                            ),
                            name: 'Compartilhamento de Exame',
                            mimeType: 'image/png',
                          ),
                        ],
                        subject:
                            'Exame ${widget.currentItem['name']} ${activePage + 1}',
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
