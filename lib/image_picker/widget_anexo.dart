import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class Anexo extends StatefulWidget {
  List<String>? base64Image;

  Anexo({super.key, required this.base64Image});

  @override
  State<Anexo> createState() => _AnexoState();
}

class _AnexoState extends State<Anexo> {
  late PageController _pageController;
  int activePage = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: PageView.builder(
              itemCount: widget.base64Image?.length,
              pageSnapping: true,
              onPageChanged: (page) {
                setState(() {
                  activePage = page;
                });
              },
              itemBuilder: (context, pagePosition) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  child: Image.memory(
                    base64Decode(
                      widget.base64Image![pagePosition].toString(),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
