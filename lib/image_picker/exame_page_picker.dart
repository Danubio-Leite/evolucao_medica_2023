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
                      'Tire uma foto',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.black,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('ou'),
                ),
                OutlinedButton.icon(
                  onPressed: () => getFileFromGallery(),
                  icon: const Icon(Icons.attach_file),
                  label: Text(exame!.isEmpty
                      ? 'Selecionar Exame'
                      : 'Adicionar Outro Exame'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context, base64Image);
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Salvar Exame'),
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
