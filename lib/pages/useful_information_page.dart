import 'package:flutter/material.dart';

class UsefulInfoPage extends StatelessWidget {
  const UsefulInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 163, 178),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 35, 163, 178),
        title: const Text(
          'Informações Úteis',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Image.asset('assets/images/abacate.png'),
      ),
    );
  }
}
