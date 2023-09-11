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
  late PageController _pageController;
  int activePage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exames'),
      ),
      body: PageView.builder(
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
            margin: const EdgeInsets.all(10),
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
    );
  }
}
