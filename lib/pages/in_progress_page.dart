import 'package:flutter/material.dart';

class InProgressPage extends StatelessWidget {
  const InProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(178, 95, 189, 226),
      ),
      body: Container(
        width: double.infinity,
        color: const Color.fromARGB(178, 95, 189, 226),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 150,
            ),
            SizedBox(
              height: 180,
              child: Image.asset('assets/images/snorlax.gif'),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Função em desenvolvimento...',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
