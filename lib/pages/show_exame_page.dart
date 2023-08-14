import 'package:flutter/material.dart';
import 'dart:convert';

class ShowExamePage extends StatefulWidget {
  Map currentItem;
  ShowExamePage({super.key, required this.currentItem});

  @override
  State<ShowExamePage> createState() => _ShowExamePageState();
}

class _ShowExamePageState extends State<ShowExamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exames'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.memory(
                base64Decode(
                  widget.currentItem['exames'].toString(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
