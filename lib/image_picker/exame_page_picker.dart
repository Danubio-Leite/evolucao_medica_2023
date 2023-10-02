import 'dart:io';
import 'package:evolucao_medica_2023/image_picker/widget_anexo.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class ExamePagePicker extends StatefulWidget {
  const ExamePagePicker(exame, {super.key});

  @override
  State<ExamePagePicker> createState() => _ExamePagePickerState();
}

class _ExamePagePickerState extends State<ExamePagePicker> {
  List<String>? base64Image = [];
  List<File>? exame = [];
  final picker = ImagePicker();
  final PageController _pageController = PageController(initialPage: 0);
  int activePage = 0;

  Future getFileFromGallery() async {
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(
        () => exame?.add(File(file.path)),
      );
      List<int> imageBytes = exame![exame!.length - 1].readAsBytesSync();
      print(imageBytes);
      base64Image?.add(base64Encode(imageBytes));
      print(base64Image);
    }
  }

  Future getFileFromCamera() async {
    final file = await picker.pickImage(source: ImageSource.camera);

    if (file != null) {
      setState(
        () => exame?.add(File(file.path)),
      );
      List<int> imageBytes = exame![exame!.length - 1].readAsBytesSync();
      print(imageBytes);
      base64Image?.add(base64Encode(imageBytes));
      print(base64Image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Envio de Exames',
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (exame != null) Anexo(base64Image: base64Image!),
                ElevatedButton.icon(
                  onPressed: () => getFileFromCamera(),
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  label: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Fotografar',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.black,
                  ),
                ),
                OutlinedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () => getFileFromGallery(),
                  icon: const Icon(Icons.image, color: Colors.white),
                  label: Text(
                      style: const TextStyle(color: Colors.white),
                      exame!.isEmpty
                          ? 'Selecionar da Galeria'
                          : 'Adicionar Outro Exame'),
                ),

                // OutlinedButton.icon(
                //   style: ElevatedButton.styleFrom(
                //     elevation: 0.0,
                //     backgroundColor: Colors.black,
                //   ),
                //   onPressed: () => getFileFromGallery(),
                //   icon: const Icon(Icons.document_scanner, color: Colors.white),
                //   label: Text(
                //       style: const TextStyle(color: Colors.white),
                //       exame!.isEmpty
                //           ? 'Selecionar PDF'
                //           : 'Adicionar Outro Exame'),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context, base64Image);
                    },
                    icon: const Icon(Icons.save, color: Colors.black),
                    label: const Text(
                      'Salvar Exame',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
