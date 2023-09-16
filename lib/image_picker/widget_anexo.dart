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
  final PageController _pageController = PageController(initialPage: 0);
  int activePage = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        width: 250,
        child: Column(
          children: [
            SizedBox(
              height: 250,
              width: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: PageView.builder(
                  controller: _pageController,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                widget.base64Image!.length,
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
          ],
        ),
      ),
    );
  }
}
