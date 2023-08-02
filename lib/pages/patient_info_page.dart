import 'package:flutter/material.dart';
import '../config/data_service.dart';

class PatientInfoPage extends StatefulWidget {
  const PatientInfoPage({super.key});

  @override
  State<PatientInfoPage> createState() => _PatientInfoPageState();
}

class _PatientInfoPageState extends State<PatientInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color.fromARGB(255, 86, 145, 88),
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(
          top: 30,
          bottom: 15,
          left: 15,
          right: 15,
        ),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Row(
              children: [
                Text(
                  'Nome:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Nome Completo',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Text(
                  'Leito:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Apto 201',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const Wrap(
              children: [
                Text(
                  'Evolução:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Paciente Mario, sexo masculino, 82 anos, admitido nessa unidade no dia 25/04. Lista de problemas atual: P1) Choque séptico sec. à ITU;  - Problema pelo qual o paciente foi admitido(em uso de ceftriaxone Di: x)P2) HPB;  -  É um problema que eu posso associar ao P1P3) Disfunção renal – IRA pós-renal – RESOLVIDO;   - se não souber, nãodefinir se pós ou préP4) HASP5) DAC com passado de RVM (stent farmacológico – 2010) – importante prasaber se ainda preciso de dupla anti-agregaçãoP6) FA (anticoagulado com Xarelto)',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Voltar',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            "Indisponível",
                            textAlign: TextAlign.center,
                          ),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text('Função em Desenvolvimento'),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Voltar',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Mais Informações',
                    style: TextStyle(color: Colors.black),
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
