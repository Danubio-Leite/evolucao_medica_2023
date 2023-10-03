import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 163, 178),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 35, 163, 178),
        title: const Text(
          'Sobre o App',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Este aplicativo foi desenvolvido por Danúbio Leite para fins de estudo, qualquer uso prático é de responsabilidade do usuário.',
                      style: TextStyle(color: Colors.black),
                    ),
                    const Text(
                      'Dúvidas ou sugestões? Manda um email para danubioalves@gmail.com.',
                      style: TextStyle(color: Colors.black),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              style: const TextStyle(color: Colors.black),
                              text:
                                  'Quer conhecer outros projetos que estou desenvolvendo? Clica '),
                          TextSpan(
                            text: 'aqui',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(
                                  Uri.parse('https://github.com/Danubio-Leite'),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Image.asset(
                  'assets/images/blue.png',
                  height: 70,
                ),
              ),
            ]),
      ),
    );
  }
}
