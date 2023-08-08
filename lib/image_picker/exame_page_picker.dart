import 'dart:io';
import 'package:camera_camera/camera_camera.dart';
import 'package:evolucao_medica_2023/image_picker/preview_page.dart';
import 'package:evolucao_medica_2023/image_picker/widget_anexo.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';

class ExamePagePicker extends StatefulWidget {
  const ExamePagePicker({super.key});

  @override
  State<ExamePagePicker> createState() => _ExamePagePickerState();
}

class _ExamePagePickerState extends State<ExamePagePicker> {
  File? exame;
  final picker = ImagePicker();

  Future getFileFromGallery() async {
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(
        () => exame = File(file.path),
      );
    }
  }

  showPreview(file) async {
    file = await Get.to(() => PreviewPage(file: file));

    if (file != null) {
      setState(() => exame = file);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Envio de Exames'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (exame != null) Anexo(exame: exame!),
                ElevatedButton.icon(
                  onPressed: () => Get.to(
                    () => CameraCamera(
                      onFile: (file) => showPreview(file),
                    ),
                  ),
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
                  label: const Text('Selecione um exame'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
