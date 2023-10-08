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
  final TextEditingController? _controllerWeight = TextEditingController();
  final TextEditingController? _controllerMgSoro = TextEditingController();
  final TextEditingController? _controllerMlSoro = TextEditingController();

  double? _mlHr = 0;
  double? _weight = 0;
  double? _mgSoro = 0;
  double? _mlSoro = 0;
  double? _mgml = 0;
  double? _mgHr = 0;
  double? _mcgKgMin = 0;

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
          padding: const EdgeInsets.only(
            bottom: 50,
            left: 12,
            right: 12,
          ),
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
                    height: 300,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.number,
                            //inputFormatters: [heightFormatter],
                            decoration: InputDecoration(
                              hintText: 'mL/h',
                              suffixText: 'mL/h',
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(23, 107, 102, 102),
                              label: const Text('mL/h'),
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
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
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
                            controller: _controllerWeight,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'mg no soro',
                              suffixText: 'mg',
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(23, 107, 102, 102),
                              label: const Text('mg no Soro'),
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
                            controller: _controllerMgSoro,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '250mL ou 500mL',
                              suffixText: 'mL',
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(23, 107, 102, 102),
                              label: const Text('Volume da bolsa'),
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
                            controller: _controllerMlSoro,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_mcgKgMin != 0)
                    Text(
                      '${_mcgKgMin!.toStringAsFixed(2)} mcg/kg/min',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  CustomWhiteButton(
                      label: 'Calcular',
                      onpressed: () {
                        if (_mlHr! >= 0 &&
                            _weight! >= 0 &&
                            _mgSoro! >= 0 &&
                            _mlSoro! >= 0) {
                          setState(() {
                            if (_controllerMlHr!.text != '') {
                              _mlHr = double.parse(_controllerMlHr!.text);
                            }
                            if (_controllerWeight!.text != '') {
                              _weight = double.parse(_controllerWeight!.text);
                            }
                            if (_controllerMgSoro!.text != '') {
                              _mgSoro = double.parse(_controllerMgSoro!.text);
                            }
                            if (_controllerMlSoro!.text != '') {
                              _mlSoro = double.parse(_controllerMlSoro!.text);
                            }
                            _mcgKgMin =
                                ((((_mgSoro! / _mlSoro!) * _mlHr!) * 1000) /
                                        _weight!) /
                                    60;
                          });
                        }
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
