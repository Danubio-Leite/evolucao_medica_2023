import 'package:flutter/material.dart';

class InProgressPage extends StatelessWidget {
  const InProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 151, 178, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 151, 178, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 180,
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
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
