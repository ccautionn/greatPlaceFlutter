import 'dart:io';
import 'package:flutter/material.dart';
import '../widget/image_input.dart';
import '../providers/great_places.dart';
import 'package:provider/provider.dart';
import '../widget/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage = File('');

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savedPlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }

    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(),
                  ImageInput(
                    onSelectImage: _selectImage,
                  ),
                  const SizedBox(height: 10),
                  LocationInput()
                ],
              ),
            ),
          )),
          TextButton.icon(
              onPressed: _savedPlace,
              style: TextButton.styleFrom(
                  elevation: 0,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: Theme.of(context).colorScheme.secondary),
              icon: const Icon(Icons.add),
              label: const Text('Add a Place')),
        ],
      ),
    );
  }
}
