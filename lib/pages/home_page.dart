import 'package:evolucao_medica_2023/pages/about_app_page.dart';
import 'package:evolucao_medica_2023/pages/in_progress_page.dart';
import 'package:evolucao_medica_2023/pages/patients_list_page.dart';
import 'package:evolucao_medica_2023/pages/useful_information_page.dart';
import 'package:flutter/material.dart';
import '../components/CustomHomeButtom.dart';
import 'cronometro_rcp_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 163, 178),
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
                        height: 20,
                      ),
                      CustomHomeButtom(
                        image: 'assets/images/informacoes.png',
                        label: 'Informações Úteis',
                        route: UsefulInfoPage,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      CustomHomeButtom(
                        image: 'assets/images/sala_vermelha.png',
                        label: 'Cronômetro RCP',
                        route: CronoRCPPage(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomHomeButtom(
                        image: 'assets/images/sobre.png',
                        label: 'Sobre o App',
                        route: AboutAppPage(),
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
