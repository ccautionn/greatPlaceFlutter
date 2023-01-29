import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  const ImageInput({super.key, required this.onSelectImage});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    var imageFile;
    await picker
        .pickImage(source: ImageSource.camera, maxWidth: 600)
        .then((file) {
      imageFile = file == null ? null : File(file!.path);
    });
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile!.path);
    final saveFilePath = '${appDir.path}/$fileName';
    final savedImage = await imageFile.copy(saveFilePath);
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 100,
            height: 100,
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
            alignment: Alignment.center,
            child: _storedImage != null
                ? Image.file(
                    _storedImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : const Text(
                    'No Image Taken',
                    textAlign: TextAlign.center,
                  )),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: TextButton.icon(
                onPressed: _takePicture,
                icon: const Icon(Icons.camera),
                label: const Text('Take Picture'))),
      ],
    );
  }
}
