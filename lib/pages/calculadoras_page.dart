import 'package:evolucao_medica_2023/pages/about_app_page.dart';
import 'package:evolucao_medica_2023/pages/in_progress_page.dart';
import 'package:evolucao_medica_2023/pages/patients_list_page.dart';
import 'package:evolucao_medica_2023/pages/useful_information_page.dart';
import 'package:flutter/material.dart';
import '../components/CustomHomeButtom.dart';
import 'cronometro_rcp_page.dart';

class CalculadorasPage extends StatelessWidget {
  const CalculadorasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 35, 163, 178),
        title: const Text('Calculadoras'),
      ),
      backgroundColor: Color.fromARGB(255, 35, 163, 178),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 100),
                  child: const Column(
                    children: [
                      CustomHomeButtom(
                        image: 'assets/images/imc.png',
                        label: 'IMC',
                        route: Placeholder(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomHomeButtom(
                        image: 'assets/images/uti.png',
                        label: 'Drogas UTI',
                        route: Placeholder(),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 100),
                  child: const Column(
                    children: [
                      CustomHomeButtom(
                        image: 'assets/images/mcg.png',
                        label: 'MCG / KG / MIN',
                        route: Placeholder(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomHomeButtom(
                        image: 'assets/images/sala_vermelha.png',
                        label: 'Indice IgG',
                        route: Placeholder(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
