import 'package:evolucao_medica_2023/pages/developing_page.dart';
import 'package:evolucao_medica_2023/pages/patients_list_page.dart';
import 'package:flutter/material.dart';

import '../components/CustomHomeButtom.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 86, 145, 88),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/images/home.png',
                    height: 135,
                  ),
                  const Column(
                    children: [
                      Text(
                        'Evolução',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 10,
                        color: Colors.white,
                      ),
                      Text(
                        'de Pacientes',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  height: MediaQuery.of(context).size.height,
                  child: const Column(
                    children: [
                      CustomHomeButtom(
                        image: 'assets/images/pacientes.png',
                        label: 'Lista de Pacientes',
                        route: PatientListPage(
                          title: 'Lista de Pacientes',
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      CustomHomeButtom(
                        image: 'assets/images/sala_vermelha.png',
                        label: 'Sala Vermelha',
                        route: DevelopingPage(),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  height: MediaQuery.of(context).size.height,
                  child: const Column(
                    children: [
                      CustomHomeButtom(
                        image: 'assets/images/informacoes.png',
                        label: 'Informações Úteis',
                        route: DevelopingPage(),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      CustomHomeButtom(
                        image: 'assets/images/sobre.png',
                        label: 'Sobre o App',
                        route: DevelopingPage(),
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
