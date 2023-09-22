import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    side: const BorderSide(
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
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
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Voltar'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _pages.removeAt(activePage);
                                      });

                                      Navigator.pop(context);
                                      print(_pages);
                                    },
                                    child: const Text('Excluir'),
                                  ),
                                ]),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Excluir',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      side: const BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              "Função em Desenvolvimento",
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Voltar'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Voltar'),
                                    ),
                                  ]),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Compartilhar',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
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
