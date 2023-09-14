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
  final List<String> _pages = [];

  @override
  void initState() {
    final List<String> _pages = widget.currentItem['exames'];

    print('_pages.lenght é ${_pages.length}');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exames'),
      ),
      body: Stack(
        children: [
          PageView.builder(
            //2h para descobrir que faltava o controller
            controller: _pageController,
            scrollBehavior: const CupertinoScrollBehavior(),
            itemCount: widget.currentItem['exames'] != null
                ? widget.currentItem['exames'].length
                : 1,
            pageSnapping: true,
            onPageChanged: (page) {
              setState(() {
                activePage = page;
              });
            },
            itemBuilder: (context, pagePosition) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: widget.currentItem['exames'][pagePosition] != null
                    ? Image.memory(
                        base64Decode(
                          widget.currentItem['exames'][pagePosition].toString(),
                        ),
                      )
                    : const Center(
                        child: Text('Paciente Sem Exames Cadastrados.'),
                      ),
              );
            },
          ),
          Positioned(
            bottom: 300,
            left: 5,
            height: 50,
            width: 50,
            child: Container(
              color: Colors.black54,
              child: InkWell(
                onTap: () {
                  if (_pageController.hasClients) {
                    _pageController.animateToPage(activePage - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.decelerate);
                  }
                },
                child: const Expanded(
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 300,
            right: 5,
            height: 50,
            width: 50,
            child: Container(
              color: Colors.black54,
              child: InkWell(
                onTap: () {
                  if (_pageController.hasClients) {
                    _pageController.animateToPage(activePage + 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.decelerate);
                  }
                },
                child: const Expanded(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
