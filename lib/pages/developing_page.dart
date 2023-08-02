import 'package:flutter/material.dart';

class DevelopingPage extends StatelessWidget {
  const DevelopingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 86, 145, 88),
        title: const Text('Em Desenvolvimento'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 86, 145, 88),
      ),
    );
  }
}
