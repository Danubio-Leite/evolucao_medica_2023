import 'package:evolucao_medica_2023/components/custom_white_buttom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MCGPage extends StatefulWidget {
  const MCGPage({super.key});

  @override
  State<MCGPage> createState() => _MCGPageState();
}

class _MCGPageState extends State<MCGPage> {
  GlobalKey<FormState> _formKey = GlobalKey();
  final heightFormatter = MaskTextInputFormatter(
    mask: '#.##',
    filter: {'#': RegExp(r'[0-9]')},
  );
  final TextEditingController? _controllerMlHr = TextEditingController();
  final TextEditingController? _controllerHeight = TextEditingController();

  double? _mlHr = 0;
  double? _weight = 0;
  double? _mgSoro = 0;
  double? _mlSoro = 0;
  double? _imc = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(178, 95, 189, 226),
        title: const Text(
          'MCG/KG/MIN',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(178, 95, 189, 226),
          padding:
              const EdgeInsets.only(bottom: 50, left: 12, right: 12, top: 40),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 70, bottom: 30),
                child: Text(
                  'Cálculo: ML / HORA EM MCG / KG / MIN ',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: Key(_mlHr.toString()),
                            //initialValue: _mlHr.toString(),
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.number,
                            inputFormatters: [heightFormatter],

                            decoration: InputDecoration(
                              hintText: '0.00',
                              suffixText: 'm',
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(23, 107, 102, 102),
                              label: const Text('Altura'),
                              isDense: true,
                              labelStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            controller: _controllerHeight,
                            onChanged: (IMCPageState) {
                              if (_weight != 0) {
                                setState(() {
                                  if (_controllerHeight!.text != '') {
                                    _mlHr =
                                        double.parse(_controllerHeight!.text);
                                  }
                                  if (_controllerMlHr!.text != '') {
                                    _weight =
                                        double.parse(_controllerMlHr!.text);
                                  }
                                  _imc = (_weight! /
                                      ((_mlHr! / 100) * (_mlHr! / 100)));
                                });
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            key: Key(_formKey.toString()),
                            //initialValue: _weight.toString(),
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '00.00',
                              suffixText: 'Kg',
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(23, 107, 102, 102),
                              label: const Text('Peso'),
                              isDense: true,
                              labelStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            controller: _controllerMlHr,
                            onChanged: (IMCPageState) {
                              if (_mlHr! >= 0 && _weight! >= 0) {
                                setState(() {
                                  if (_controllerHeight!.text != '') {
                                    _mlHr =
                                        double.parse(_controllerHeight!.text);
                                  }
                                  if (_controllerMlHr!.text != '') {
                                    _weight =
                                        double.parse(_controllerMlHr!.text);
                                  }
                                  _imc = (_weight! / ((_mlHr)! * (_mlHr)!));
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_imc != 0)
                    SizedBox(
                      height: 100,
                      child: Text(
                        'O IMC do paciente é ${_imc?.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  if (_imc! < 18.5 && _imc! > 0)
                    const SizedBox(
                      height: 100,
                      child: Text(
                        'Paciente com baixo peso',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  if (_imc! >= 18.5 && _imc! < 25)
                    const SizedBox(
                      height: 100,
                      child: Text(
                        'Paciente com peso normal',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  if (_imc! >= 25 && _imc! < 30)
                    const SizedBox(
                      height: 100,
                      child: Text(
                        'Paciente com excesso de peso',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  if (_imc! >= 30 && _imc! < 35)
                    const SizedBox(
                      height: 100,
                      child: Text(
                        'Paciente com obesidade de classe 1',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  if (_imc! >= 35 && _imc! < 40)
                    const SizedBox(
                      height: 100,
                      child: Text(
                        'Paciente com obesidade classe 2',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  if (_imc! >= 40)
                    const SizedBox(
                      height: 100,
                      child: Text(
                        'Paciente com obesidade classe 3',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
